install.packages("pacman")

pacman::p_load("tidyverse", "rvest", "janitor")

#URL
url_filmes <- "https://pt.wikipedia.org/wiki/Lista_de_filmes_de_maior_bilheteria"
pagina_filmes <- read_html(url_filmes)
tabela_filmes <- html_table(pagina_filmes)

datafilmes <- tabela_filmes[[1]]

datafilmes <- datafilmes %>% 
  clean_names() %>% 
  select(-c(6)) 

glimpse(datafilmes)

datafilmes$bilheteria_us  <- as.numeric(
  as.character(
    str_replace_all(
      datafilmes$bilheteria_us, "\\s",""
    )
  )
) 

datafilmes$distribuidor <- as.factor(
  as.character(
    datafilmes$distribuidor
  )
)

datafilmes$ano <- as.factor(
  as.integer(
    datafilmes$ano
  )
)

summary(datafilmes)


options(scipen = 999)
