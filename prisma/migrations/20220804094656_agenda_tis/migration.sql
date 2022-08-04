/*
  Warnings:

  - The primary key for the `departamento` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pk_departamento` column on the `departamento` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `edificio` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pk_edificio` column on the `edificio` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `funcao` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pk_funcao` column on the `funcao` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `participante` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `prioridade_reuniao` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pk_prioridade` column on the `prioridade_reuniao` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `reuniao` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pk_reuniao` column on the `reuniao` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `sala` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pk_sala` column on the `sala` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `usuario` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pk_usuario` column on the `usuario` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `fk_usuario` on the `contacto` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `fk_departamento` on the `funcao` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `fk_usuario` on the `participante` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `fk_reuniao` on the `participante` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `fk_prioridade` on the `reuniao` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `fk_edificio` on the `sala` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `fk_funcao` on the `usuario` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "contacto" DROP CONSTRAINT "contacto_contactoId_fkey";

-- DropForeignKey
ALTER TABLE "funcao" DROP CONSTRAINT "funcao_departamentoId_fkey";

-- DropForeignKey
ALTER TABLE "participante" DROP CONSTRAINT "participante_reuniaoId_fkey";

-- DropForeignKey
ALTER TABLE "participante" DROP CONSTRAINT "participante_userId_fkey";

-- DropForeignKey
ALTER TABLE "reuniao" DROP CONSTRAINT "reuniao_prioridadeId_fkey";

-- DropForeignKey
ALTER TABLE "sala" DROP CONSTRAINT "sala_edificio_fkey";

-- DropForeignKey
ALTER TABLE "usuario" DROP CONSTRAINT "usuario_fk_funcao_fkey";

-- AlterTable
ALTER TABLE "contacto" DROP COLUMN "fk_usuario",
ADD COLUMN     "fk_usuario" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "departamento" DROP CONSTRAINT "departamento_pkey",
DROP COLUMN "pk_departamento",
ADD COLUMN     "pk_departamento" SERIAL NOT NULL,
ADD CONSTRAINT "departamento_pkey" PRIMARY KEY ("pk_departamento");

-- AlterTable
ALTER TABLE "edificio" DROP CONSTRAINT "edificio_pkey",
DROP COLUMN "pk_edificio",
ADD COLUMN     "pk_edificio" SERIAL NOT NULL,
ADD CONSTRAINT "edificio_pkey" PRIMARY KEY ("pk_edificio");

-- AlterTable
ALTER TABLE "funcao" DROP CONSTRAINT "funcao_pkey",
DROP COLUMN "pk_funcao",
ADD COLUMN     "pk_funcao" SERIAL NOT NULL,
DROP COLUMN "fk_departamento",
ADD COLUMN     "fk_departamento" INTEGER NOT NULL,
ADD CONSTRAINT "funcao_pkey" PRIMARY KEY ("pk_funcao");

-- AlterTable
ALTER TABLE "participante" DROP CONSTRAINT "participante_pkey",
DROP COLUMN "fk_usuario",
ADD COLUMN     "fk_usuario" INTEGER NOT NULL,
DROP COLUMN "fk_reuniao",
ADD COLUMN     "fk_reuniao" INTEGER NOT NULL,
ADD CONSTRAINT "participante_pkey" PRIMARY KEY ("fk_usuario", "fk_reuniao");

-- AlterTable
ALTER TABLE "prioridade_reuniao" DROP CONSTRAINT "prioridade_reuniao_pkey",
DROP COLUMN "pk_prioridade",
ADD COLUMN     "pk_prioridade" SERIAL NOT NULL,
ADD CONSTRAINT "prioridade_reuniao_pkey" PRIMARY KEY ("pk_prioridade");

-- AlterTable
ALTER TABLE "reuniao" DROP CONSTRAINT "reuniao_pkey",
DROP COLUMN "pk_reuniao",
ADD COLUMN     "pk_reuniao" SERIAL NOT NULL,
DROP COLUMN "fk_prioridade",
ADD COLUMN     "fk_prioridade" INTEGER NOT NULL,
ADD CONSTRAINT "reuniao_pkey" PRIMARY KEY ("pk_reuniao");

-- AlterTable
ALTER TABLE "sala" DROP CONSTRAINT "sala_pkey",
DROP COLUMN "pk_sala",
ADD COLUMN     "pk_sala" SERIAL NOT NULL,
DROP COLUMN "fk_edificio",
ADD COLUMN     "fk_edificio" INTEGER NOT NULL,
ADD CONSTRAINT "sala_pkey" PRIMARY KEY ("pk_sala");

-- AlterTable
ALTER TABLE "usuario" DROP CONSTRAINT "usuario_pkey",
DROP COLUMN "pk_usuario",
ADD COLUMN     "pk_usuario" SERIAL NOT NULL,
DROP COLUMN "fk_funcao",
ADD COLUMN     "fk_funcao" INTEGER NOT NULL,
ADD CONSTRAINT "usuario_pkey" PRIMARY KEY ("pk_usuario");

-- AddForeignKey
ALTER TABLE "contacto" ADD CONSTRAINT "contacto_contactoId_fkey" FOREIGN KEY ("fk_usuario") REFERENCES "usuario"("pk_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "funcao" ADD CONSTRAINT "funcao_departamentoId_fkey" FOREIGN KEY ("fk_departamento") REFERENCES "departamento"("pk_departamento") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "participante" ADD CONSTRAINT "participante_reuniaoId_fkey" FOREIGN KEY ("fk_reuniao") REFERENCES "reuniao"("pk_reuniao") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "participante" ADD CONSTRAINT "participante_userId_fkey" FOREIGN KEY ("fk_usuario") REFERENCES "usuario"("pk_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reuniao" ADD CONSTRAINT "reuniao_prioridadeId_fkey" FOREIGN KEY ("fk_prioridade") REFERENCES "prioridade_reuniao"("pk_prioridade") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sala" ADD CONSTRAINT "sala_edificio_fkey" FOREIGN KEY ("fk_edificio") REFERENCES "edificio"("pk_edificio") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuario" ADD CONSTRAINT "usuario_fk_funcao_fkey" FOREIGN KEY ("fk_funcao") REFERENCES "funcao"("pk_funcao") ON DELETE RESTRICT ON UPDATE CASCADE;
