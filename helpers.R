graf_frec<-function(varfrec,base){
  if(!(varfrec %in% c('P7.1','P9.1','P14','P14a.1'))){
    base2<-base %>%
      dplyr::select(one_of(varfrec,'ponderador'))
    names(base2)<-c('x','ponderador')
    base2<-base2[!is.na(base2$x),]
    
    if(!is.null(levels(base2$x))){
      ggplot(base2,aes(x,fill=x,weight=ponderador))+
        geom_bar(aes(y = (..count..)/sum(..count..)*100)) + 
        xlab('')+
        ylab('')+
        theme(axis.text.x=element_text(angle=90,size=22),
              axis.text.y=element_text(size=22),
              panel.background=element_rect(fill='#C2D1E0'),
              panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
              strip.background=element_rect(fill="#2c3e50"),
              legend.text=element_text(size=15),
              strip.text.x = element_text(colour = 'white', size = 22),
              legend.title=element_text(size=0))
      
    }else{
      ggplot(base2,aes(x,weight=ponderador))+
        geom_density(aes(y = (..count..)/sum(..count..)*100)) + 
        xlab('')+
        ylab('')+
        theme(axis.text.x=element_text(angle=90,size=22),
              axis.text.y=element_text(size=22),
              panel.background=element_rect(fill='#C2D1E0'),
              panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
              strip.background=element_rect(fill="#2c3e50"),
              legend.text=element_text(size=15),
              strip.text.x = element_text(colour = 'white', size = 22),
              legend.title=element_text(size=0))
    }
  }
}

img_frec<-function(varfrec){
  if(varfrec %in% c('P7.1','P9.1','P14','P14a.1')){
    if(varfrec=='P7.1'){
      imagen <-  "images/P71.png"
    }else{
      if(varfrec=='P9.1'){
        imagen <-  "images/P91.png"
      }else{
        if(varfrec=='P14'){
          imagen <-  "images/P14.png"
        }else{
          imagen <-  "images/P14a1.png"
        }
      }
    }
  }
  return(imagen)
}

graf_cruce<-function(c1,c2,base){
  base2<-base %>%
    dplyr::select(one_of(c1,c2,'ponderador'))
  names(base2)<-c('x','z','ponderador')
  base2<-base2[!is.na(base2$x),]
  base2<-base2[!is.na(base2$z),]
  
  
  if(!is.null(levels(base2$z))){
    ggplot(base2,aes(z,fill=z,weight=ponderador))+
      geom_bar(aes(y = (..count..)/sum(..count..)*100))+
      facet_wrap(~x)+
      xlab('')+
      ylab('')+
      theme(axis.text.x=element_text(angle=90,size=22),
            axis.text.y=element_text(size=22),
            panel.background=element_rect(fill='#C2D1E0'),
            panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
            strip.background=element_rect(fill="#2c3e50"),
            legend.text=element_text(size=15),
            strip.text.x = element_text(colour = 'white', size = 22),
            legend.title=element_text(size=0)) 
  }else{
    ggplot(base2,aes(z,weight=ponderador))+
      geom_density(aes(y = (..count..)/sum(..count..)*100,fill=x)) + 
      facet_wrap(~x)+
      xlab('')+
      ylab('')+
      theme(axis.text.x=element_text(angle=90,size=22),
            axis.text.y=element_text(size=22),
            panel.background=element_rect(fill='#C2D1E0'),
            panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
            strip.background=element_rect(fill="#2c3e50"),
            legend.text=element_text(size=15),
            strip.text.x = element_text(colour = 'white', size = 22),
            legend.title=element_text(size=0))
  }
}


graf_estructura<-function(base){
  
  diseno<-svydesign(data=base,
                    ids=~0,
                    weights=~ponderador)
  
  
  tabla_estructura<-data.frame(svymean(~estructura,diseno))
  tabla_estructura$segmento<-levels(base$estructura)
  tabla_estructura<-tabla_estructura[,c(3,1)]
  names(tabla_estructura)[2]<-'Porcentaje'
  tabla_estructura[,2]<-round(tabla_estructura[,2]*100,1)
  tabla_estructura <- tabla_estructura %>%
    arrange(desc(Porcentaje)) 
  
  tabla_estructura$segmento<-factor(tabla_estructura$segmento,
                                    levels=as.character(tabla_estructura$segmento))
 
  blank_theme <- theme_minimal()+
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid=element_blank(),
      axis.ticks = element_blank(),
      plot.title=element_text(size=14, face="bold")
    )
  
  g<-ggplot(data=tabla_estructura,aes(x='',y=Porcentaje,fill=segmento))+
    geom_bar(width=1,stat='identity')+
    coord_polar('y',start=0)+
    scale_fill_manual(values=c('azure3','forestgreen','dodgerblue2','blue3','darkred','gold1'))+
    blank_theme+
    theme(axis.text.x=element_blank(),
          legend.text=element_text(size=15),
          legend.title=element_text(size=18)) +
    geom_text(aes(y = Porcentaje/3 + c(0, cumsum(Porcentaje)[-length(Porcentaje)]), 
                  label = percent(Porcentaje/100)), size=5)
 return(g)
}

graf_opinion_conocimiento<-function(datos,filtrovar,filtrocat="Hombre"){
  if(filtrovar=="Total"){
    pond<-datos$ponderador
    datos<-datos %>% 
      dplyr::select(one_of("P15.1",
                    'P15.2',
                    'P15.3',
                    'P15.4',
                    'P15.5',
                    'P16.1',
                    'P16.2',
                    'P16.3',
                    'P16.4',
                    'P16.5'))
    
    for(i in 1:length(datos)){
      datos[,i]<-as.numeric(datos[,i])
    }
    
    medias<-data.frame(matrix(apply(datos,2,weighted.mean,pond,na.rm=T),ncol=2,nrow=5),
                       candidatos=candidatos)
    
    medias[,1]<-medias[,1]-1
    medias[,1]<-1-medias[,1]
    
    g<-ggplot(medias,aes(X1*100,X2)) +
      geom_point(size=10,aes(colour=candidatos,group=candidatos)) +
      geom_hline(yintercept=3,colour="orange") +
      geom_hline(yintercept=4,colour="green") +
      geom_vline(xintercept=50,colour="black") +
      coord_cartesian(xlim=c(0,100),ylim=c(2,5))+
      theme(axis.text.x=element_text(angle=90,size=22),
            axis.text.y=element_text(size=22),
            panel.background=element_rect(fill='#C2D1E0'),
            panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
            strip.background=element_rect(fill="#2c3e50"),
            strip.text.x = element_text(colour = 'white', size = 22),
            legend.text=element_text(size=15),
            legend.title=element_text(size=0),
            axis.title=element_text(size=22,face="bold")) +
      xlab('Porcentaje de conocimiento')+
      ylab('Opinion')
    
  }else{
    datos<-datos %>% 
      select(one_of(filtrovar,
                    'P15.1',
                    'P15.2',
                    'P15.3',
                    'P15.4',
                    'P15.5',
                    'P16.1',
                    'P16.2',
                    'P16.3',
                    'P16.4',
                    'P16.5',
                    "ponderador"))
    
    datos<-datos %>%
      filter(datos[,1]==filtrocat)
    
    datos<-datos[,2:length(datos)]
    
    for(i in 1:length(datos)){
      datos[,i]<-as.numeric(datos[,i])
    }
    
    pond<-datos[,length(datos)]
    n <- length(datos) - 1
    
    medias<-data.frame(matrix(apply(datos[1:n],2,weighted.mean,pond,na.rm=T),ncol=2,nrow=5),
                       candidatos=candidatos)
    
    medias[,1]<-medias[,1]-1
    medias[,1]<-1-medias[,1]
    
    g<-ggplot(medias,aes(X1*100,X2)) +
      geom_point(size=10,aes(colour=candidatos,group=candidatos)) +
      geom_hline(yintercept=3,colour="orange") +
      geom_hline(yintercept=4,colour="green") +
      geom_vline(xintercept=50,colour="black") +
      coord_cartesian(xlim=c(0,100),ylim=c(2,5))+
      theme(axis.text.x=element_text(angle=90,size=22),
            axis.text.y=element_text(size=22),
            panel.background=element_rect(fill='#C2D1E0'),
            panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
            strip.background=element_rect(fill="#2c3e50"),
            legend.text=element_text(size=15),
            strip.text.x = element_text(colour = 'white', size = 22),
            legend.title=element_text(size=0),
            axis.title=element_text(size=22,face="bold"))+
      xlab('Porcentaje de conocimiento')+
      ylab('Opinion')
    
  }
  return(g)
}

graf_fuerza<-function(base){
  
  diseno<-svydesign(data=base,
                    ids=~0,
                    weights=~ponderador)
  
  
  tabla_estructura<-data.frame(svymean(~fuerza,diseno))
  tabla_estructura$fuerza<-levels(base$fuerza)
  tabla_estructura<-tabla_estructura[,c(3,1)]
  names(tabla_estructura)[2]<-'Porcentaje'
  tabla_estructura[,2]<-round(tabla_estructura[,2]*100,1)
  
  tabla_estructura <- tabla_estructura %>%
    arrange(desc(Porcentaje)) 
  
  tabla_estructura$fuerza<-factor(tabla_estructura$fuerza,
                                    levels=as.character(tabla_estructura$fuerza))
  
  
  
  blank_theme <- theme_minimal()+
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid=element_blank(),
      axis.ticks = element_blank(),
      plot.title=element_text(size=14, face="bold")
    )
  
  g<-ggplot(data=tabla_estructura,aes(x='',y=Porcentaje,fill=fuerza))+
    geom_bar(width=1,stat='identity')+
    coord_polar('y',start=0)+
    scale_fill_manual(values=c('#000099','#0000CC','#0033FF','#0066CC','#0066FF'))+
    blank_theme+
    theme(axis.text.x=element_blank(),
          legend.text=element_text(size=15),
          legend.title=element_text(size=18)) +
    geom_text(aes(y = Porcentaje/3 + c(0, cumsum(Porcentaje)[-length(Porcentaje)]), 
                  label = percent(Porcentaje/100)), size=5,colour="white")
  return(g)
}

