import Razorpay from "razorpay";

console.log("API_key =", process.env.API_key);
console.log("Secret exists =",process.env.Secret);

const razorpay = new Razorpay({
  key_id: process.env.API_key,
  key_secret: process.env.Secret,
});
(async () => {
  try {
    const testOrder = await razorpay.orders.create({
      amount: 100,
      currency: "INR",
      receipt: "test_receipt"
    });

    console.log("Razorpay test success:", testOrder.id);
  } catch (e) {
    console.log("Razorpay test failed:");
    console.log(e);
  }
})();

export default razorpay