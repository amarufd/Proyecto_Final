### borrado de variables rm(list = ls())  

# Usando la librería rvest
library('rvest')

### Graficando los productos
# install.packages('ggplot2')
library('ggplot2')

##########################################################
###################### PROYECTO YAPO #####################
##########################################################

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

#Grafico de Barra de la información
contaYapo %>%
  ggplot() +
  aes(x = unlistTextoYapo , y = Freq) +
  geom_bar(stat="identity")

#### Esto es un demo

# recorriendo paginas
todosLasCategorias <- list()
for(i in 1:2){
  print(paste("https://www.yapo.cl/region_metropolitana?ca=15_s&o=",i,sep = ""))
  
  paginaDescargada <- read_html(paste("https://www.yapo.cl/region_metropolitana?ca=15_s&o=",i,sep = ""))
  contenidoYapo <- html_nodes(webpageYapo,'.category')
  texto <- html_text(contenidoYapo)
  todosLasCategorias <- c(todosLasCategorias,texto)
}

# Contando y pasando a dataframe
todosLasCategorias <- unlist(textoYapo)
tablaTextoYapo <- table(todosLasCategorias)

df <- as.data.frame(tablaTextoYapo)


##################### llevando a data.frame sólo la lista

df2 <- data.frame(todosLasCategorias = todosLasCategorias)
