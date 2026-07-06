-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_paymentId_fkey";

-- AlterTable
ALTER TABLE "Booking" ALTER COLUMN "paymentId" DROP NOT NULL,
ALTER COLUMN "meetingroomId" DROP NOT NULL,
ALTER COLUMN "recordingUrl" DROP NOT NULL,
ALTER COLUMN "transcriptUrl" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "Payment"("id") ON DELETE SET NULL ON UPDATE CASCADE;
