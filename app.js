import express from 'express'
import { prisma } from './lib/prisma.js'
import cors from 'cors'
import { log } from 'node:console'
import { configDotenv } from 'dotenv'
import crypto from 'crypto'
import multer from 'multer'
const app=express()

app.use(cors())
app.use(express.json())
import razorpay from './lib/razorpay.js'
import { slotStatus } from './generated/prisma/index.js'
import { glob } from 'node:fs'

const upload=multer({Storage:multer.memoryStorage()})
app.post('/', async(req,res)=>{
    try{
        const rest=await prisma.user.create({
            
                data: {
     auth0Id: req.body.auth0Id,
        email: req.body.email,
        name: req.body.name,
        phone: req.body.phone,
        profileImage: req.body.profileImage,
        dateOfBirth: req.body.dateOfBirth
          ? new Date(req.body.dateOfBirth)
          : null,
        birthTime: req.body.birthTime,
        birthPlace: req.body.birthPlace,
        gender: req.body.gender,
        isPremium: req.body.isPremium,
  },
});
res.status(201).json({
    message:rest
})
            }
        
    
    catch(e){
        res.status(401).json({
            message:e.message
        })
    }
})

app.post('/services', async (req, res) => {
    try {
        const result = await prisma.service.createMany({
            data: req.body
        });

        res.status(201).json({
            message: "Services inserted successfully",
            count: result.count
        });
    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: "Error inserting services"
        });
    }
});
app.get('/services',async(req,res)=>{
    const data=await prisma.service.findMany()
    res.status(200).json({
        data
    })
    
})
app.get('/services/:id', async (req, res) => {
  try {
    const { id } = req.params;

    const data = await prisma.service.findUnique({
      where: {
        id: id
      }
    });

    res.status(200).json({
      data
    });
  } catch (error) {
    res.status(500).json({
      message: "Something went wrong"
    });
  }
});
app.post('/service/create_order', async (req, res) => {
  try {
    console.log("This side order is creating");
    console.log(req.body);

    const { id } = req.body;

    const s_data = await prisma.service.findUnique({
      where: {
        id: id
      }
    });

    if (!s_data) {
      return res.status(404).json({
        message: "Service not found"
      });
    }

    const option = {
      amount: s_data.price * 100,
      currency: "INR",
      receipt: s_data.id
    };

    const order = await razorpay.orders.create(option);

    const front = {
      order_id: order.id,
      amount: order.amount,
      currency: order.currency,
      service_title: s_data.title
    };

    const serviceId = req.body.id;
    const slotId = req.body.data.id;
const userId=req.body.userId
    const min = new Date();
    const setfif = new Date(min);
    setfif.setMinutes(min.getMinutes() + 15);
const st=await prisma.slot.findUnique({
  where:{
    id:slotId
  }
})
if(st.status !=='AVAILABLE'){
  return res.status(404).json({
    message:"Slot not found"
  })
}
else{
    const booking = await prisma.booking.create({
      data: {
        serviceId: serviceId,
        slotId: slotId,
        status: "PENDING",
        userId:userId
      }
    });

    await prisma.slot.update({
      where: {
        id: slotId
      },
      data: {
        status: "RESERVED",
        reservedUntill: setfif.toISOString(),
        reservedByUserId:userId
      }
    });

    return res.status(200).json({
      success: true,
      razorpay: front,
      bookingId: booking.id,
      slotId: slotId
    });
  }
  } catch (e) {
    console.log(e);

    return res.status(500).json({
      success: false,
      message: e.message
    });
  }
});
app.post('/service/verify_payment', async (req, res) => {

  const data = req.body;

  console.log("verification is here");
  console.log(data);

  const {
    razorpay_order_id,
    razorpay_payment_id,
    razorpay_signature,
  } = data.response;
const booking = await prisma.booking.findUnique({
  where: {
    id: req.body.bookingId
  }
});

if (!booking) {
  return res.status(404).json({
    success: false,
    message: "Booking not found"
  });
}

const userId = booking.userId;
  const serviceId = req.body.id;
  
  const amount = req.body.amount;

  const bookingId = req.body.bookingId;
  const slotId = req.body.slotId;

  const body =
    razorpay_order_id + "|" + razorpay_payment_id;

  const expected_signature = crypto
    .createHmac("sha256", process.env.Secret)
    .update(body)
    .digest("hex");
const meet=crypto.randomUUID()
  const paymentData = {
    userId: userId,
    serviceId: serviceId,
    razorpayOrderId: razorpay_order_id,
    razorpayPaymentId: razorpay_payment_id,
    amount: amount,
    status: "SUCCESS"
  };

  try {

    if (expected_signature === razorpay_signature) {

      const payment = await prisma.payment.create({
        data: paymentData
      });

      await prisma.booking.update({
        where: {
          id: bookingId
        },
        data: {
          paymentId: payment.id,
          status: "CONFIRMED",
          meetingroomId:`astra-${meet}`
        }
      });

      await prisma.slot.update({
        where: {
          id: slotId
        },
        data: {
          status: "BOOKED",
          reservedUntill: null
        }
      });

      return res.status(200).json({
        success: true,
        message: "Payment verified successfully"
      });

    } else {
      await prisma.payment.create({
    data: {
      userId: userId,
      serviceId: serviceId,
      razorpayOrderId: razorpay_order_id,
      razorpayPaymentId: razorpay_payment_id || null,
      amount: amount,
      status: "FAILED"
    }
  });
await prisma.booking.update({
  where:{
    id:bookingId
  },
  data:{
      status:'CANCELLED',
      
  }
})
await prisma.slot.update({
  where:{
    id:slotId
  },
  data:{
    status:'AVAILABLE',
    reservedUntill:null,
    reservedByUserId:null,
  
  }
})
      return res.status(400).json({
        
        success: false,
        message: "Payment verification failed"
      });

    }

  } catch (err) {

    console.log(err);

    return res.status(500).json({
      success: false,
      message: err.message
    });

  }

});
app.get('/service/get_slot',async(req,res)=>{
  try{
  const date=new Date()
  date.setHours(0,0,0,0)
  await prisma.slot.deleteMany({
    where:{
      status:'AVAILABLE',
      date:{
        lt:date
      }
    }
  })
  const data = await prisma.slot.findFirst({
    orderBy :[{
      date:'desc' },{
      start:"desc"
    }]
  })
  
  if (data === null) {

  const slots = [
    { startTime: "14:00", endTime: "15:00" },
    { startTime: "16:00", endTime: "17:00" },
    { startTime: "19:00", endTime: "20:00" },
    { startTime: "20:00", endTime: "21:00" }
  ]

  const today = new Date()
  today.setHours(0,0,0,0)

  for (let i = 2; i <= 30; i++) {

    const slotDate = new Date(today)
    slotDate.setHours(0,0,0,0)
    slotDate.setDate(slotDate.getDate() + i)

    for (const slot of slots) {

      await prisma.slot.create({
        data: {
          date: slotDate,
          start: slot.startTime,
          end: slot.endTime
        }
      })

    }

  }

}
else{
  
  const last_date=data.date
  const start=data.start
  const end=data.end

  console.log(last_date,start,end);
  const d=new Date()
  d.setHours(0,0,0,0)
  const fday=new Date(d)
  fday.setHours(0,0,0,0)
  fday.setDate(fday.getDate()+30)
  const remaing_day=Math.floor((fday-last_date)/(1000*60*60*24))
  
  const slots = [
    { startTime: "14:00", endTime: "15:00" },
    { startTime: "16:00", endTime: "17:00" },
    { startTime: "19:00", endTime: "20:00" },
    { startTime: "20:00", endTime: "21:00" }
  ]
  for(var i=1;i<=remaing_day;i++){
    const day=new Date(last_date)
    day.setHours(0,0,0,0)
    day.setDate(day.getDate()+i)
    for(const slot of slots){
      await prisma.slot.create({
        data:{
          date:day,
          start:slot.startTime,
          end:slot.endTime
        }
      })
    }
  }
   console.log("Latest slot:", last_date)
console.log("Missing days:", remaing_day)
console.log("Target:", fday)
console.log("Latest:", last_date)
console.log("Raw diff:", (fday-last_date)/(1000*60*60*24))
}
const cur=new Date()
const upd=new Date(cur)
upd.setDate(cur.getDate()+2)
  const allslot = await prisma.slot.findMany({
  where:{
    status:'AVAILABLE',
    date:{
      gt:upd
    },

  },
  orderBy:{
    createdAt:'asc'
  }
})
  console.log(allslot)
  console.log(allslot)
  console.log(upd)
  res.status(201).json({
    allslot
  })
 
}
  catch(e){
     res.status(400).json({
    message:e.message
  })
  }
})

app.post('/auth/sync_user',async(req,res)=>{
  console.log(req.body)
  const {
email,
name,
picture,
sub,

  }=req.body
try{
const userDet=await prisma.user.findUnique({
  where:{
    auth0Id:sub
  }
})
if(userDet){
  return res.status(200).json({
    user:userDet
  })

}
else{
  
  const d=await prisma.user.create({
    data:{
      auth0Id:sub,
      email:email,
      name:name,
      profileImage:picture,

    }
  })
  return res.status(201).json({
    user:d
  })
}}
  catch(e){
    return res.status(500).json({
      message:e.message
    })
  }
  
}
)
app.post('/get_latest_service', async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: {
        auth0Id: req.body.sub
      }
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found"
      });
    }

    const bookings = await prisma.booking.findMany({
      where: {
        userId: user.id,
        status: "CONFIRMED"
      },
      include: {
        slot: true,
        service: true
      }
    });

    const upcoming = bookings
      .sort((a, b) => {
        const d1 = new Date(a.slot.date);
        const d2 = new Date(b.slot.date);

        if (d1.getTime() !== d2.getTime()) {
          return d1 - d2;
        }

        return a.slot.start.localeCompare(
          b.slot.start
        );
      })[0];

    return res.status(200).json({
      success: true,
      sessi: upcoming
    });

  } catch (e) {
    return res.status(500).json({
      success: false,
      message: e.message
    });
  }
});
app.post('/service_user',async (req,res)=>{
  try{
    const data=await prisma.booking.findMany({
      where:{
        userId:req.body.userId
      }
    })
  }
  catch(e){
    return res.status(400).json({
      'message':e.message
    })
  }
})
app.get('/meeting/access/:bookingId', async (req, res) => {

  const booking = await prisma.booking.findUnique({
    where: {
      id: req.params.bookingId
    }
  });

  if (!booking) {
    return res.status(404).json({
      success: false,
      message: "Booking not found"
    });
  }

  if (booking.userId !== req.query.userId) {
    return res.status(403).json({
      success: false,
      message: "Unauthorized"
    });
  }

  if (booking.status !== "CONFIRMED") {
    return res.status(400).json({
      success: false,
      message: "Booking not confirmed"
    });
  }

  if (!booking.meetingroomId) {
    return res.status(400).json({
      success: false,
      message: "Meeting room not ready"
    });
  }

  return res.status(200).json({
    success: true,
    roomId: booking.meetingroomId
  });
});
app.post('/get_booking_details',async (req,res)=>{
  console.log(req.body.id);
  try{
  const booking=await prisma.booking.findMany({
    where:{
      userId:req.body.id,
      slot:{
        status:'BOOKED',
        date:{
          gte:new Date()
        }
      }
    },
    include:{
      service:true,
      slot:true
    },
    orderBy:{
      slot:{
        date:"asc"
      }
    }
  })
  return res.status(200).json({
    'data':booking
  })
}
catch(e){
  return res.status(400).json({
    'message':e.message
  })
}

  
})
app.post('/get_all_booking_details',async (req,res)=>{
  
  try{
  const booking=await prisma.booking.findMany({
    where:{
      userId:req.body.id,
      
      
    },
    include:{
      service:true,
      slot:true
    },
    orderBy:{
      slot:{
        date:'asc'
      }
    }
  })
  return res.status(200).json({
    'data':booking
  })
}
catch(e){
  return res.status(400).json({
    'message':e.message
  })
}
})







  


app.post('/get_payment_details',async (req,res)=>{
  try{
  if(req.body.dbuser){
    const userid=req.body.dbuser.id
    log(userid)
    const det=await prisma.payment.findMany({
      where:{
        userId:userid
      },
      include:{
        service:true,
       
      }
    })
   return res.status(200).json({
    det:det
   })
    
  }}
  catch(e){
    return res.status(400).json({
      message:e.message
    })
  }
  
})
//astrologer veri

app.post('/astra_astrologer_verification',async(req,res)=>{
  console.log(req.body);
  const email=req.body.email
  const pass=req.body.pass
 const password= crypto.createHash('sha256').update(pass).digest('hex')
  console.log(password);
  const det= await prisma.astrologer.findFirst({
  where: {
    email: email,
    pass: password 
  }
});
  if(det){
    return res.status(200).json({
      message:"Verified"
    })
  }
  else{
     return res.status(400).json({
      message:"Not Verified"
    })
  }

})
app.get('/astologer_booking_page', async (req,res)=>{
  try{
const det = await prisma.booking.findMany({
  where: {
    slot: {
      date: {
        gte: new Date(),
      },
    },
  },
  include: {
    slot: true,
    user: true,
    service: true,
  },
  orderBy: [
    {
      slot: {
        date: 'asc',
      },
    },
    {
      slot: {
        start: 'asc',
      },
    },
  ],
});
  return res.status(200).json({
    'data':det
  })
  }
  catch(e){
    return res.status(404).json({
      'message':e.message
    })
  }
  
  
})
app.post('/astra_booking_completed',async (req,res)=>{
  console.log(req.body.bookingId);
  const daet=await prisma.booking.update({
  where: {
    id: req.body.bookingId
  },
  data: {
    status: "COMPLETED",
  },
});
  
})
app.post('/create_service', async (req, res) => {
  try {

    const service = await prisma.service.create({
      data: {
        title: req.body.title,
        category: req.body.category,
        description: req.body.description,
        image: req.body.image,
        price: Number(req.body.price)
      }
    });

    res.json({
      success: true,
      service
    });

  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false
    });
  }
});
app.post('/get_service', async (req, res) => {
  try {

    const data = await prisma.service.findUnique({
      where: {
        id: req.body.id
      },
      include: {
        booking: true
      }
    });

    res.json({
      success: true,
      data
    });

  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false
    });
  }
});
app.post('/update_service', async (req, res) => {
  try {

    const data = await prisma.service.update({
      where: {
        id: req.body.id
      },

      data: {
        title: req.body.title,
        category: req.body.category,
        description: req.body.description,
        image: req.body.image,
        price: Number(req.body.price)
      }
    });

    res.json({
      success: true,
      data
    });

  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false
    });
  }
});
app.post('/delete_service', async (req, res) => {
  try {

    await prisma.service.delete({
      where: {
        id: req.body.id
      }
    });

    res.json({
      success: true
    });

  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false
    });
  }
});
app.get('/all_services', async (req, res) => {
  try {
    const data = await prisma.service.findMany({
      include: {
        booking: true
      }
    });

    res.json({
      success: true,
      data
    });

  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false
    });
  }
});

export default app