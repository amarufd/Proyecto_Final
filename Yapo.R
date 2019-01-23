### borrado de variables rm(list = ls())  

# Usando la librería rvest
library('rvest')

### Graficando los productos
# install.packages('ggplot2')
library('ggplot2')

##########################################################
###################### PROYECTO YAPO #####################
##########################################################

# Abrir csv
if(file.exists("fileTextoYFreqYapo.txt")){
  print("Abre CSV")
  fileTextoYFreqYapo <- read.table(file = "fileTextoYFreqYapo.txt", header = TRUE, sep = " ")
}

#==================== usando Yapo.cl ====================#

paginaYapo <- 'https://www.yapo.cl/region_metropolitana?ca=15_s&o=1'

webpageYapo <- read_html(paginaYapo)

# Extracción del texto contenido en la clase thumb-under
contenidoYapo <- html_nodes(webpageYapo,'.category')

# viendo el contenido de la variable contenidoYapo
print(contenidoYapo)

# Extrayendo el texto de contenidoYapo
textoYapo <- html_text(contenidoYapo)

# Viendo que tiene la posición 1 la variable textoYapo
print(textoYapo)

# Contando palabras
unlistTextoYapo <- unlist(textoYapo)
tablaTextoYapo <- table(unlistTextoYapo)

# Transformando a data framtabla
contaYapo <- as.data.frame(tablaTextoYapo)



#### Esto es un demo

# recorriendo paginas
todosLasCategorias <- list()
for(i in 1:100){
  print(paste("https://www.yapo.cl/region_metropolitana?ca=15_s&o=",i,sep = ""))
  
  paginaDescargada <- read_html(paste("https://www.yapo.cl/region_metropolitana?ca=15_s&o=",i,sep = ""))
  contenidoYapo <- html_nodes(webpageYapo,'.category')
  texto <- html_text(contenidoYapo)
  todosLasCategorias <- c(todosLasCategorias,texto)
}

# Contando y pasando a dataframe
tablaTextoYapo <- table(unlist(todosLasCategorias))
dfTextoYFreqYapo <- as.data.frame(tablaTextoYapo)

if(exists("fileTextoYFreqYapo")){
  print("Uniendo los DataFrames")
  # uniendo dos dataframes por Var1 sumando frecuencias
  dfTextoYFreqYapo <- aggregate(cbind(Freq) ~ Var1, rbind(dfTextoYFreqYapo,dfTextoYFreqYapo), sum)
}

#Grafico de Barra de la información
dfTextoYFreqYapo %>%
  ggplot() +
  aes(x = Var1 , y = Freq) +
  geom_bar(stat="identity")

# Guardando información en txt
write.table(dfTextoYFreqYapo, file="fileTextoYFreqYapo.txt")
