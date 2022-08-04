-- CreateEnum
CREATE TYPE "Perfil" AS ENUM ('USER', 'ADMIN');

-- CreateEnum
CREATE TYPE "estado_reuniao" AS ENUM ('APROVADO', 'ESPERA', 'REJEITADO');

-- CreateTable
CREATE TABLE "contacto" (
    "fk_usuario" TEXT NOT NULL,
    "numero" TEXT NOT NULL,

    CONSTRAINT "contacto_pkey" PRIMARY KEY ("numero")
);

-- CreateTable
CREATE TABLE "departamento" (
    "pk_departamento" TEXT NOT NULL,
    "nome" TEXT NOT NULL,

    CONSTRAINT "departamento_pkey" PRIMARY KEY ("pk_departamento")
);

-- CreateTable
CREATE TABLE "edificio" (
    "pk_edificio" TEXT NOT NULL,
    "nome" TEXT NOT NULL,

    CONSTRAINT "edificio_pkey" PRIMARY KEY ("pk_edificio")
);

-- CreateTable
CREATE TABLE "funcao" (
    "pk_funcao" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "fk_departamento" TEXT NOT NULL,

    CONSTRAINT "funcao_pkey" PRIMARY KEY ("pk_funcao")
);

-- CreateTable
CREATE TABLE "participante" (
    "fk_usuario" TEXT NOT NULL,
    "fk_reuniao" TEXT NOT NULL,

    CONSTRAINT "participante_pkey" PRIMARY KEY ("fk_usuario","fk_reuniao")
);

-- CreateTable
CREATE TABLE "prioridade_reuniao" (
    "pk_prioridade" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "prioridade_reuniao_pkey" PRIMARY KEY ("pk_prioridade")
);

-- CreateTable
CREATE TABLE "reuniao" (
    "pk_reuniao" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "duracao" TEXT NOT NULL,
    "date_realizacao" TIMESTAMP(3) NOT NULL,
    "tempo_inicio" TIMESTAMP(3) NOT NULL,
    "tempo_final" TIMESTAMP(3) NOT NULL,
    "estado_reuniao" "estado_reuniao" NOT NULL DEFAULT 'ESPERA',
    "fk_prioridade" TEXT NOT NULL,

    CONSTRAINT "reuniao_pkey" PRIMARY KEY ("pk_reuniao")
);

-- CreateTable
CREATE TABLE "sala" (
    "pk_sala" TEXT NOT NULL,
    "fk_edificio" TEXT NOT NULL,
    "piso" TEXT NOT NULL,
    "nome" TEXT NOT NULL,

    CONSTRAINT "sala_pkey" PRIMARY KEY ("pk_sala")
);

-- CreateTable
CREATE TABLE "usuario" (
    "pk_usuario" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "fk_funcao" TEXT NOT NULL,
    "perfil" "Perfil" NOT NULL DEFAULT 'USER',

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("pk_usuario")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuario_email_key" ON "usuario"("email");

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
