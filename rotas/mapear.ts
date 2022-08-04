import express from 'express'
import { PrismaClient } from '@prisma/client';
import { connect } from 'http2';

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

// post Alterar palavra-passe
app.post('/alteraPasse', async (req: any, res: any) => {
    console.log("estou dentro");
    console.clear();


    const result = await prisma.usuario.update({
        where: { pk_usuario: req.body.pk_usuario },
        data: {
            "password": req.body.password,
        }
    });
});


/*
function organizarDados(dados:any){
    
  const dado=// caso não quer difinir!= null ? dados.funcao: undefined ,}

    return dado;
}*/

// post do registrar
app.post('/cadastrarDados', async (req: any, res: any) => {
    console.log("estou dentro");
    console.clear();


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

});

// função add
app.post('/funcao', async (req, res) => {
    const { nome, departamento } = req.body;
    console.log(departamento.id+" "+departamento.nome);
    
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
});

// departamento add
app.post('/departamento', async (req, res) => {
    const { nome, id_dp } = req.body;

    const result = await prisma.departamento.create({
        data: {
            nome: nome,
        }
    });

    res.send(result.toString + " resultado------------------------");
});

// post do login
app.post('/loginDados', async (req, res) => {
    const { nome, password } = req.body;

    const result = await prisma.usuario.findMany({
        where: {
            name: nome,
            password: password
        },
        select : {
            perfil: true,
        }
    });
    res.send(result);
   //(result.includes(1 )? res.send(result.toString + " resultado-------- USER -----------") : res.send(result.toString + " resultado------ Admin -------------")
});

const port = process.env.PORT || 3000;
/*
main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })*/

app.listen(port, () => {
    console.log(`Listening to requests on port http://localhost:${port}`);
});