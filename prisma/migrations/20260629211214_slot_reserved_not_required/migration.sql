-- AlterTable
ALTER TABLE "Slot" ALTER COLUMN "reservedByUserId" DROP NOT NULL,
ALTER COLUMN "reservedUntill" DROP NOT NULL;
