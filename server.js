import app from './app.js'
import { configDotenv } from 'dotenv'
const PORT=process.env.PORT||3000
app.listen(PORT,()=>{
    console.log("Server is Running")
})