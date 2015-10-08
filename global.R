library(shiny)
library(Hmisc)
library(ggplot2)
library(stringr)
library(scales)
library(survey)
library(dplyr)

source('helpers.R')

datos<-load('data/workspace.RData')
catalogo<-read.csv("data/codigos.csv")
catalogo[,1]<-as.character(catalogo[,1])
