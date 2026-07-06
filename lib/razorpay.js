import Razorpay from "razorpay";
import { configDotenv } from "dotenv";
const razorpay=new Razorpay({
    key_id:process.env.API_key,
    key_secret:process.env.Secret
})
export default razorpay