import express from 'express'
import { Prisma, PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const app = express();
var bodyParser = require('body-parser')

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

prisma.$use(async (params: any, next: any) => {
    // Manipulate params here
    const result = await next(params)
    // See results here
    return result
})

// padroes da  palavra-passe
/*
O método de requisição HTTP PUT cria um novo recurso ou subsititui uma representação do recurso de destino com os novos dados.

A diferença entre PUT e POST é que PUT é idempotente: chamá-lo uma ou várias vezes sucessivamente terá o mesmo efeito 
(não é um efeito colateral), enquanto usar POST repetidamente pode ter efeitos adicionais, como passar uma ordem várias vezes.*/
// post Alterar palavra-passe
app.put('/alteraPasse', async (req: any, res: any) => {
    console.log("estou dentro");
    console.clear();

    try {
        const result = await prisma.usuario.update({
            where: { pk_usuario: req.body.pk_usuario },
            data: {
                "password": req.body.password,
            }
        });
    } catch (e:any) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            // The .code property can be accessed in a type-safe manner
            if (e.code === 'P2002') {
                console.log(
                    'There is a unique constraint violation, a new user cannot be created with this email'
                )
            }
        }
        throw e
    }
});




// post do registrar usuario
app.post('/cadastrarDados', async (req: any, res: any) => {
    console.log("estou dentro");
    console.clear();

    try {
        const result = await prisma.usuario.create({
            data: {
                "email": req.body.email,
                "name": req.body.name,
                "password": req.body.password,
                "perfil": req.body.perfil,
                "funcao": { connect: { pk_funcao: req.body.funcao } }
                /*"connectOrCreate" :{
                     where:{ "pk_funcao" : req.body.funcao.id}
                     , create : {"nome"  :req.body.funcao.nome, departamento: } 
                    }, 
                }*/
            }
        });

        console.log(result);
        res.send(result)
    } catch (e:any) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            // The .code property can be accessed in a type-safe manner
            if (e.code === 'P2002') {
                console.log(
                    'There is a unique constraint violation, a new user cannot be created with this email'
                )
            }
        }
        throw e
    }



});

// post do listar usuario
app.post('/listarUsuario', async (req: any, res: any) => {
    console.log("estou dentro");
    console.clear();

    try {
        const result = await prisma.usuario.findMany({

        });

        console.log(result);
        res.send(result)
    } catch (e:any) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            // The .code property can be accessed in a type-safe manner
            if (e.code === 'P2002') {
                console.log(
                    'There is a unique constraint violation, a new user cannot be created with this email'
                )
            }
        }
        throw e
    }



});


// função add
app.post('/funcao', async (req, res) => {
    const { nome, departamento } = req.body;
    console.log(departamento.id + " " + departamento.nome);
    try {
        const result = await prisma.funcao.create({
            data: {
                nome: nome,
                departamento: {
                    connectOrCreate: {
                        where: {
                            pk_departamento: departamento.id
                        },
                        create: {
                            nome: departamento.nome
                        }
                    }
                }

            }
        });
        res.send(result.toString + " resultado------------------------");
    } catch (e:any) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            // The .code property can be accessed in a type-safe manner
            if (e.code === 'P2002') {
                console.log(
                    'There is a unique constraint violation, a new user cannot be created with this email'
                )
            }
        }
        throw e
    }


});


// função listar
app.post('/listarFuncao', async (req, res) => {
    const { nome, departamento } = req.body;
    console.log(departamento.id + " " + departamento.nome);

    try {
        const result = await prisma.funcao.findMany({

        });
        res.send(result);

    } catch (e:any) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            // The .code property can be accessed in a type-safe manner
            if (e.code === 'P2002') {
                console.log(
                    'There is a unique constraint violation, a new user cannot be created with this email'
                )
            }
        }
        throw e
    }


});

// departamento add
app.post('/departamento', async (req, res) => {
    const { nome, id_dp } = req.body;
    try {
        const result = await prisma.departamento.create({
            data: {
                nome: nome,
            }
        });

        res.send(result.toString + " resultado------------------------");

    } catch (e:any) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            // The .code property can be accessed in a type-safe manner
            if (e.code === 'P2002') {
                console.log(
                    'There is a unique constraint violation, a new user cannot be created with this email'
                )
            }
        }
        throw e
    }


});


// post do login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    try {
        const result = await prisma.usuario.findUnique({
            where: {
                email: email,
            },

            select: {
                perfil: true,
                password: true,
                name: true
            }
        });


        if (result != null) {
            if (result.password == password)
                res.send(result)
            else
                res.send("senha errada")

        }
        else res.send("Usuario não encontrado");


    } catch (e:any) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            // The .code property can be accessed in a type-safe manner
            if (e.code === 'P2002') {
                console.log(
                    'There is a unique constraint violation, a new user cannot be created with this email'
                )
            }else
            console.log(" erro "+e);
            
        }
        throw e
    }



    //(result.includes(1 )? res.send(result.toString + " resultado-------- USER -----------") : res.send(result.toString + " resultado------ Admin -------------")
});


app.post('/disconectarBD', async (req, res) => {

    try
        {await prisma.$disconnect();}
     catch (e:any) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            // The .code property can be accessed in a type-safe manner
            if (e.code === 'P2002') {
                console.log(
                    'There is a unique constraint violation, a new user cannot be created with this email'
                )
                await prisma.$disconnect();
            }
        }
        throw e
    }
});


const port = process.env.PORT || 3000;



app.listen(port, () => {
    console.log(`Listening to requests on port http://localhost:${port}`);
});