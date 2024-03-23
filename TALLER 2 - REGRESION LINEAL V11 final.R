library(readxl)
library(dplyr)
library(ggplot2)
library(corrplot)
library(xlsx)
library(psych)
library(caret)#para variables dummy

DatosEnt <- read.delim("ventas_exam_model_muj.txt", header = TRUE, sep = "\t")
DatosPrue <- read.delim("ventas_exam_qualify_muj.txt", header = TRUE, sep = "\t")
#DatosEnt$promo<-as.factor(DatosEnt$promo)
VariableE<-DatosEnt
VariableE$idloc<-NULL
VariableE <- select(DatosEnt,-c(idloc))

#-------------------VARIABLES PRIMER MODELO-----------------------------------#

variables<-dummyVars("~.",data=VariableE)

Variablefin<-as.data.frame(predict(variables,newdata=VariableE))

Variablefin2<-select(Variablefin,-c(tamañomer.Pequeño))

Variablefin2<-Variablefin
Variablefin2$tamañomer.Pequeño<-NULL
#-------------------VARIABLES SEGUNDO MODELO-----------------------------------#
Variablefin2.2<-Variablefin2

#Variablefin2.2<-cbind(Variablefin2,((Variablefin2$correo)^2),((Variablefin2$teléfono)^2),((Variablefin2$idmercado)^2),((Variablefin2$páginas)^2),((Variablefin2$impresa)^2), ((Variablefin2$servicio)^2),((Variablefin2$edadloc)^3),((Variablefin2$promo)^2),((Variablefin2$nomina)^2))
#MODELO CON TODAS LAS VARIABLES
Variablefin2.2<-cbind(Variablefin2,((Variablefin2$correo)^2),((Variablefin2$edadloc)^2),(Variablefin2$idmercado*Variablefin2$teléfono))

modelo2<- lm(ropamujer ~.,data=Variablefin2.2)
summary(modelo2)

erro<-modelostep2$residuals

atipicos<-c("66","91","71")
veratipicos<-Variablefin2.2[atipicos,]



plot(modelo2)

#MODELADO STEP BY STEP

modelostep2<- step(modelo2,direction="both")
summary(modelostep2)

autoplot(modelostep2)
VariableRespuesta<-Variablefin2.2
ggplot(modelostep2, aes(x = VariableRespuesta$ropamujer, y = .resid)) + geom_point(colour="#8C4966")+ labs(y = "Residuos")


plot(Variablefin2.2$promo,modelostep2$residuals)
correlacion<-round(cor(Variablefin2.2), 1)
n<-correlacion
library(MASS)
library(leaps)
modelsub<-regsubsets(ropamujer~.,data=Variablefin2.2, nbest=1, nvmax=13, method = "exhaustive") 
summary(modelsub)

summary(modelsub)$adjr2
summary(modelsub)$cp
summary(modelsub)$bic



nnn<-DatosPrue
nnn<-cbind(nnn,((nnn$correo)^2),((nnn$edadloc)^2))
colnames(nnn)[13]<-"CorreoCuadrado"
colnames(nnn)[14]<-"EdadCuadrado"

colnames(Variablefin2.2)[13]<-"CorreoCuadrado"
colnames(Variablefin2.2)[14]<-"EdadCuadrado"

predstep2<-predict(modelostep2, nnn, se.fit=TRUE)
ropamujer<-predstep2$fit
idloc<-DatosPrue$idloc
resul2<-cbind(idloc,ropamujer)
write.table(resul2, "C:/Users/ASUS/Documents/Resul7.txt",sep = ",", dec = ".",row.names = FALSE)

  
modelo0<- lm(ropamujer ~ correo + páginas + impresa + servicio + idmercado,data=Variablefin2.2)
summary(modelo0)

plot(modelo0)

predstep2<-predict(modelo0, DatosPrue, se.fit=TRUE)

ropamujer<-predstep2$fit

idloc<-DatosPrue$idloc
resul2<-cbind(idloc,ropamujer)
write.table(resul2, "C:/Users/ASUS/Documents/Resul3.txt",sep = ",", dec = ".",row.names = FALSE)


atipicos<-c("66","91","71")
veratipicos<-Variablefin2.2[atipicos,]
atiptc<-apply(veratipicos,2,mean)
todostc<-apply(Variablefin2.2,2,mean)
comparar<-as.data.frame(cbind(atiptc,todostc))

plot(Variablefin2.2$ropamujer,modelo0$residuals)



modelo2<- lm(ropamujer ~ raizcorre+ correo + páginas + impresa + servicio + idmercado,data=Variablefin2.2)
summary(modelo2)
plot(modelo2)


