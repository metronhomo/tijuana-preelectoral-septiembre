library(shiny)
library(shinythemes)


shinyUI(
  navbarPage(theme=shinytheme('flatly'),
             'Encuesta Preelectoral Tijuana',
             tabPanel("Objetivo del estudio",
                      column(8,imageOutput('portada')),
                      column(2,h2('El estudio tiene como objetivo analizar la fuerza de los precandidatos a la 
                                        presidencia municipal de Tijuana, dar un primer esbozo de la estructura electoral 
                                        de Tijuana y dar directivas generales de estrategia.'))),
             navbarMenu('Descriptivos',
               tabPanel('Frecuencias',
                        column(3,
                               wellPanel(
                                 tags$style(type='text/css', 
                                            ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                                 selectInput('varfrec',
                                             label=h4('Variable'),
                                             choices=eval(parse(text=paste('list(',paste('"',catalogo[,2],'"="',catalogo[,1],'"',collapse=',',sep=''),')'))),
                                             selected=9
                                 ),
                                 p('Selecciona la variable de la que quieres obtener las frecuencias. 
                                 En el caso de las preguntas categóricas obtendrás gráficas de barras, para 
                                 las variables continuas gráficos de densidad y para las preguntas abiertas 
                                 nubes de texto.')
                               )
                              
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
                               wellPanel(
                                 tags$style(type='text/css', ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                                 
                                 selectInput('c1',label=h4('Variables para cruce'),
                                             choices=eval(parse(text=paste('list(',paste('"',catalogo[-c(4,5,7,9,16,17,43,49,52),2],'"="',catalogo[-c(4,5,7,9,16,17,43,49,52),1],'"',collapse=',',sep=''),')'))),
                                             selected=6
                                 ),
                                 tags$style(type='text/css', ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                                 
                                 selectInput('c2',label=h4(''),
                                             choices=eval(parse(text=paste('list(',paste('"',catalogo[-c(4,5,7,9,16,17,43,49,52),2],'"="',catalogo[-c(4,5,7,9,16,17,43,49,52),1],'"',collapse=',',sep=''),')'))),
                                             selected=6
                                 ),
                                 p('Selecciona el par de variables con las que quieres calcular la gráfica de cruce. 
                                   Si seleccionas la misma variable 2 veces no obtendrás ninguna gráfica.')
                               )
                        ),
                        column(9,plotOutput('cruce',height=1000,width=1000),align="center")
               )
             ),
             tabPanel('Estructura Electoral',
                      column(7,
                             wellPanel(style = "background-color: #0099FF;color:black",
                                       h5('Segmento PAN/anti-PRI',style = "font-size:12pt"),
                                       h6('Este es el segmento duro del PAN, su voto por el partido es bastante seguro y tienen poca probabilidad de 
                                          cambiarlo, manifiestan una simpatía muy débil por el PRD y una muy fuerte aversión por el PRI.',style = "font-size:12pt")),
                             wellPanel(style = "background-color: #003399;color:#C2D1E0",
                                       h5('Segmento PAN con propensión PRI',style = "font-size:12pt"),
                                       h6('Manifiestan una intención de voto por el PAN. Sin embargo su segunda intención de votar está 
                                          fuertemente direccionada al PRI, y no manifiestan ninguna aversión por dicho partido. Es un grupo que se deberá 
                                          cuidar, sobre todo en el caso de un candidato carismático. Manifiestan aversión por el PRD.',style = "font-size:12pt")
                                       ),
                             wellPanel(style = "background-color: forestgreen;color:black",
                                       h5('Segmento PRI',style = "font-size:12pt"),
                                       h6('Tienen una clara intención de voto por el PRI. Sin embargo dentro de este grupo existe un subconjunto de personas 
                                          que son susceptibles a votar por el PAN en caso de que éste oferte una mejor opción de gobierno.',style = "font-size:12pt")),
                             wellPanel(style = "background-color: darkred;color:#C2D1E0",
                                       h5('Segmento Morena',style = "font-size:12pt"),
                                       h6('Tienen una intención de voto por Morena, el driver de su intención de voto es Andrés Manuel, ya que manifiestan 
                                          muy poca cercanía con cualquiera de los otros partidos incluyendo el PRD. Sin embargo es un voto de "alternancia", 
                                          es decir, este grupo no es leal a Morena, simplemente desean votar por una nueva opción de gobierno. Este grupo 
                                          podría ser clave para el candidato independiente que surja.',style = "font-size:12pt")),
                 wellPanel(style = "background-color: #FFFF33;color:black",
                           h5('Segmento PRD',style = "font-size:12pt"),
                           h6('Posiblemente votarán por el PRD. Está constituido por el voto de castigo para los dos principales partidos (PAN y PRI).
                              Existe una aversión moderada por PAN y PRI (siendo esta más marcada contra el PRI). No es un voto duro como lo 
                              indica su cercanía partidísta heterogénea. Al igual que el grupo anterior es posible que apoyen al 
                              candidato independiente, pero en proporción mucho menor.',style = "font-size:12pt")),
                 wellPanel(style = "background-color: #B0B0B0 ;color:black",
                           h5('Segmento apático',style = "font-size:12pt"),
                           h6('Están cansados de la política o simplemente no les interesa, este grupo por sí mismo no es relevante. 
                              Sin embargo hay que notar que ciertos patrones de aversión son parecidos a los de otros grupos, es decir, 
                              los grupos anteriores que manifiestan aversión al PRI están sobre-estimados, en el sentido de que 
                              un porcentaje de esas personas eventualmente pasarán a formar parte de este grupo. Disminuyendo así 
                              la base de votantes del PAN.',style = "font-size:12pt"))
               ),
               column(5,wellPanel(style = "background-color: #2c3e50;",
                 h2('Estructura Electoral de Tijuana',style = "font-size:18pt;color:#C2D1E0"),
                 p('La situación general para el partido es buena, la mayoría del voto manifestado es panista. Sin embargo hay ciertas precauciones 
                   que se deben tomar.',style = "font-size:13pt;color:#C2D1E0")
               ),
                      plotOutput('estructura',width=800,height=800)
               )
             ),
             navbarMenu('Candidatos',
                        tabPanel('Opinión y conocimiento de candidatos',
                                 column(4,
                                        fluidRow(wellPanel(
                                          selectInput('filtrovar',label=h4('Variable de filtro'),
                                                      choices=list('Sexo'='Sexo','Edad'='Edad',
                                                                   "Total" = "Total",'Votante probable'='vp3',
                                                                   "Estructura Electoral"="estructura",
                                                                   "Escolaridad" = "Escolaridad"),
                                                      selected=6
                                          ),
                                          radioButtons('filtrocat',label=h4('Categoría de filtro'),
                                                       choices=list('Hombre'='Hombre','Mujer'='Mujer')),
                                          p('Selecciona la variable sobre la que quieres filtrar, y después 
                                            selecciona la categoría de filtro.'),
                                          p('En el eje horizontal está el conocimiento, aumentando de izquierda 
                                            a derecha. En el eje vertical la opinión promedio, aumentando 
                                            de abajo hacia arriba.')
                                        )),
                                        fluidRow(wellPanel(
                                          style = "background-color: #2c3e50;",
                                          h2('Conocimiento y Opinión',align="center",style = "color:#C2D1E0"),
                                          tags$ul(
                                            tags$li('Antonio tiene marginalmente una mejor opinión que Gastelum.',style = "color:#C2D1E0; font-size:16pt"),
                                            tags$li('Los jóvenes tienen una opinión más negativa en general.',style = "color:#C2D1E0; font-size:16pt"),
                                            tags$li('En el grupo de 25-54 años Antonio tiene una mejor opinión, en los grupos 
                                                    de jovenes y viejos no hay diferencias entre él y Gastelum.',style = "color:#C2D1E0; font-size:16pt"),
                                            tags$li('El votante probable tiene un mayor conocimiento sobre personajes. Además en este segmento René es un rival fuerte.',style = "color:#C2D1E0; font-size:16pt"),
                                            tags$li('Antonio es la mejor opción dentro de los simpatizantes del partido. René es el mejor visto entre 
                                                    los votantes del PRI y  Saúl Guakil tiene una buena percepción entre el voto alternativo',style = "color:#C2D1E0; font-size:16pt")
                                            )
                                            ))),
                                 column(8,plotOutput('opinion',height=800,width=1000),align="center")
                        ),
                        tabPanel('Estructura de preferencia de candidatos',
                                 column(5,
                                        wellPanel(style = "background-color: #000099;color:white",
                                                  h4('Grupo de indecisión entre Gastelum y Antonio',style = "font-size:16pt"),
                                                  h6('No hay una preferencia por ninguno de los dos candidatos',style = "font-size:16pt")),
                                        
                                        wellPanel(style = "background-color: #0000CC;color:white",
                                                  h4('Segmento que no manifiesta preferencias',style = "font-size:16pt"),
                                                  h6('No manifiestan preferencia por ningún personaje',style = "font-size:16pt")),
                                        
                                        wellPanel(style = "background-color: #0033FF;color:white",
                                                  h4('Grupo de indecisión general',style = "font-size:16pt"),
                                                  h6('No hay un patrón de respuesta marcado.',style = "font-size:16pt")),
                                        
                                        wellPanel(style = "background-color: #0066CC;color:white",
                                                  h4('Segmento de apatía',style = "font-size:16pt"),
                                                  h6('Eligieron "ninguno" como opción en todas las preguntas.',style = "font-size:16pt")),
                                        
                                        wellPanel(style = "background-color: #0066FF;color:white",
                                                  h4('Grupo de Antonio',style = "font-size:16pt"),
                                                  h6('En este grupo la preferencia es marcada por Antonio, Gastelum recibe rechazo.',style = "font-size:16pt"))
                                  ),
                                 column(7,plotOutput('fuerza',width=1000,height=1000)
                                 )))
             
    
  )
)