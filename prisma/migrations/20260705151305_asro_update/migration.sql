/*
  Warnings:

  - A unique constraint covering the columns `[email]` on the table `Astrologer` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[pass]` on the table `Astrologer` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Astrologer_email_key" ON "Astrologer"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Astrologer_pass_key" ON "Astrologer"("pass");
