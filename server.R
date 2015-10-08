library(shiny)
library(shinythemes)

shinyServer(function(input,output,session){
  
  observe({
    if(input$filtrovar!="Total"){
      datos1<-base %>%
        dplyr::select(one_of(input$filtrovar))
      
      r_options<-eval(parse(text=paste('list(',paste('"',levels(datos1[,1]),'"="',levels(datos1[,1]),'"',
                                                     collapse=',',sep=''),')')))
    }else{
      r_options<-"Total"
    }
    updateRadioButtons(session,'filtrocat',choices=r_options)
  })
  
  output$cruce<-renderPlot({
    if(input$c1!=input$c2){
      graf_cruce(input$c1,input$c2,base)
    }
  })
  
  output$estructura<-renderPlot({
    graf_estructura(base)
  })
  
  output$my_test1<-renderPlot({
    graf_frec(input$varfrec,base)
  })
  
  output$my_test2 <- renderImage({
    list(src=img_frec(input$varfrec),
         filetype='image/png',
         width=800,
         height=800,
         alt='wiiiii')
  }, 
  deleteFile = F)
  
  output$opinion<-renderPlot({
    graf_opinion_conocimiento(base,input$filtrovar,input$filtrocat)
  })
  
  output$fuerza<-renderPlot({
    graf_fuerza(base)
  })
  
  
  output$portada<-renderImage({
    list(src='images/portada.jpg',
         filetype='image/jpeg',
         alt='wiiiii',
          height=800,
            widht=800)
  }, 
  deleteFile = F)
  
})