import Razorpay from "razorpay";

console.log("RAZORPAY FILE LOADED");

console.log("API_key =", process.env.API_key);
console.log("Secret exists =", !!process.env.Secret);

const razorpay = new Razorpay({
  key_id: process.env.API_key,
  key_secret: process.env.Secret
});

console.log("RAZORPAY INSTANCE CREATED");

(async () => {
  console.log("STARTING TEST");

  try {
    const testOrder = await razorpay.orders.create({
      amount: 100,
      currency: "INR",
      receipt: "test_receipt"
    });

    console.log("SUCCESS");
    console.log(testOrder.id);

  } catch (e) {
    console.log("FAILED");
    console.log(e);
  }
})();

export default razorpay;