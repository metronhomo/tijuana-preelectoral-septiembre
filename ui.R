library(shiny)
library(shinythemes)

shinyUI(navbarPage(theme = shinytheme("Flatly"),
                   'Encuesta preelectoral Tijuana',
                   
                   tabPanel('Frecuencias',
                            column(3,
                                   fluidRow(wellPanel(
                                   tags$style(type='text/css', 
                                         ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                              
                                   selectInput('varfrec',label=h4('Variable'),
                                          choices=eval(parse(text=paste('list(',paste('"',catalogo[,2],'"="',catalogo[,1],'"',collapse=',',sep=''),')'))),
                                          selected=1
                                          )
                                          )),
                                   fluidRow(wellPanel(
                                     style = "background-color: #2c3e50;",
                                     h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                                     p('La batería es consistente y es estadísticamente correcto suponer la existencia de un índice único que 
                                               resuma adecuadamente a la batería.',style = "color:#C2D1E0; font-size:16pt"),
                                     p('Asimismo comenzamos a ver pequeños clusters de correlaciones, por ejemplo vemos que las variables 
                                               relacionadas con la evaluación del "jefe" tienen correlaciones altas, esto es importante para derivar 
                                               índices secundarios.',style = "color:#C2D1E0; font-size:16pt")
                                     
                                   ))
                            ),
                            column(9, align="center",
                                   conditionalPanel(
                                     condition = "input.varfrec  == 'P7.1' ||
                                                  input.varfrec  == 'P9.1' ||
                                                  input.varfrec  == 'P14' ||
                                                  input.varfrec  == 'P14a.1'",
                                     imageOutput("my_test2")
                                   ),
                                   conditionalPanel(
                                     condition = "input.varfrec  != 'P7.1' &&
                                                  input.varfrec  != 'P9.1' &&
                                                  input.varfrec  != 'P14' &&
                                                  input.varfrec  != 'P14a.1'",
                                     plotOutput("my_test1",width=800,height=800)
                                   ))),

                   tabPanel('Cruces',
                            column(3,
                                   fluidRow(wellPanel(
                                            tags$style(type='text/css', ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                              
                                          selectInput('c1',label=h4('Variables para cruce'),
                                                    choices=eval(parse(text=paste('list(',paste('"',catalogo[-c(4,5,7,9,16,17,43,49,52),2],'"="',catalogo[-c(4,5,7,9,16,17,43,49,52),1],'"',collapse=',',sep=''),')'))),
                                                    selected=6
                                           ),
                                          tags$style(type='text/css', ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                              
                                          selectInput('c2',label=h4(''),
                                                    choices=eval(parse(text=paste('list(',paste('"',catalogo[-c(4,5,7,9,16,17,43,49,52),2],'"="',catalogo[-c(4,5,7,9,16,17,43,49,52),1],'"',collapse=',',sep=''),')'))),
                                                    selected=6
                                          )
                            )),
                            fluidRow(wellPanel(
                              style = "background-color: #2c3e50;",
                              h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                              p('La batería es consistente y es estadísticamente correcto suponer la existencia de un índice único que 
                                               resuma adecuadamente a la batería.',style = "color:#C2D1E0; font-size:16pt"),
                              p('Asimismo comenzamos a ver pequeños clusters de correlaciones, por ejemplo vemos que las variables 
                                               relacionadas con la evaluación del "jefe" tienen correlaciones altas, esto es importante para derivar 
                                               índices secundarios.',style = "color:#C2D1E0; font-size:16pt")
                              
                            ))
                                   
                                   
                            ),
                            column(9,
                                   plotOutput('cruce',height=800,width=800))
                            ),
                   navbarMenu('Candidatos',
                              tabPanel('Opinión y conocimiento de candidatos',
                                       column(3,
                                              fluidRow(wellPanel(
                                                      selectInput('filtrovar',label=h4('Variable de filtro'),
                                                      choices=list('Sexo'='Sexo','Edad'='Edad',"Total"),
                                                      selected=6
                                                      ),
                                              radioButtons('filtrocat',label=h4('Categoría de filtro'),
                                                          choices=list('Hombre'='Hombre','Mujer'='Mujer'))
                                              )),
                                              fluidRow(wellPanel(
                                                style = "background-color: #2c3e50;",
                                                h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                                                p('La batería es consistente y es estadísticamente correcto suponer la existencia de un índice único que 
                                               resuma adecuadamente a la batería.',style = "color:#C2D1E0; font-size:16pt"),
                                                p('Asimismo comenzamos a ver pequeños clusters de correlaciones, por ejemplo vemos que las variables 
                                               relacionadas con la evaluación del "jefe" tienen correlaciones altas, esto es importante para derivar 
                                               índices secundarios.',style = "color:#C2D1E0; font-size:16pt")
                                                
                                              ))),
                                       column(9,plotOutput('opinion',height=800,width=800))
                              ))
                   ))