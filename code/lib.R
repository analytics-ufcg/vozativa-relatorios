theme_report <- function(base_size = 11,
                         strip_text_size = 12,
                         strip_text_margin = 5,
                         subtitle_size = 13,
                         subtitle_margin = 10,
                         plot_title_size = 16,
                         plot_title_margin = 10,
                         ...) {
    ret <- ggplot2::theme_minimal(base_family = "Roboto-Regular",
                                  base_size = base_size, ...)
    ret$strip.text <- ggplot2::element_text(hjust = 0, size=strip_text_size,
                                            margin=margin(b=strip_text_margin),
                                            family="Roboto-Bold")
    ret$plot.subtitle <- ggplot2::element_text(hjust = 0, size=subtitle_size,
                                               margin=margin(b=subtitle_margin),
                                               family="PT Sans")
    ret$plot.title <- ggplot2::element_text(hjust = 0, size = plot_title_size,
                                             margin=margin(b=plot_title_margin),
                                            family="Oswald")
    ret
}

import_data <- function(){
    library(tidyverse)
    
    fetched = jsonlite::fromJSON("https://voz-ativa-producao.herokuapp.com/api/respostas", flatten = T)
    # respostas = jsonlite::fromJSON("https://voz-ativa.herokuapp.com/api/respostas", flatten = T)
    respostas = fetched[["data"]]
    
    respostas %>% 
        filter(!is.na(nome_urna)) %>% 
        write_csv(here::here("data/estado-dos-candidatos.csv"))
}

read_projectdata <- function(){
    read_csv(here::here("data/estado-dos-candidatos.csv"), 
             col_types = cols(
                 .default = col_integer(),
                 `_id` = col_character(),
                 date_modified = col_datetime(format = ""),
                 date_created = col_datetime(format = ""),
                 email = col_character(),
                 nome_urna = col_character(),
                 nome_exibicao = col_character(),
                 uf = col_character(),
                 sg_partido = col_character(),
                 cpf = col_character(),
                 respondeu = col_logical(),
                 recebeu = col_logical(),
                 respostas.129411238 = col_character(),
                 respostas.129520614 = col_character(),
                 respostas.129521027 = col_character()
             ))
}
