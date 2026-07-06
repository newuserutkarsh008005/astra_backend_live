import Razorpay from "razorpay";

console.log("API_key =", process.env.API_key);
console.log("Secret exists =",process.env.Secret);

const razorpay = new Razorpay({
  key_id: process.env.API_key,
  key_secret: process.env.Secret,
});

export default razorpay