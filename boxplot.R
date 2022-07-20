install.packages("tidyverse")

pacman::p_load("tidyverse")



glimpse(datafilmes)

unique(datafilmes$distribuidor)

datafilmes$distribuidor <- str_replace(datafilmes$distribuidor, 
                                       "Universal Studios", 
                                       "Universal Pictures") 

ggplot(data = datafilmes)+
  geom_boxplot(aes(x = distribuidor, y = bilheteria_us))

summary(datafilmes$bilheteria_us)

options(scipen = 999)

distrib_famosos <- datafilmes %>% 
  filter(distribuidor == "Universal Pictures" |
           distribuidor == "Walt Disney Studios Motion Pictures" |
           distribuidor == "Warner Bros. Pictures")

summary(distrib_famosos)

g_bloxpot_filmes <- ggplot(data = distrib_famosos)+
  geom_boxplot(aes(x = distribuidor,
                   y = bilheteria_us,
                   fill = distribuidor),
               show.legend = F,
               varwidth = T)+
  labs(title = "Boxplot das Maiores Bilheterias por Distribuidor",
       subtitle = "Em bilhões de dólares",
       x = "",
       y = "Bilheteria alcançada",
       caption = "Fonte: Wikipedia")+
scale_y_continuous(breaks = c(0.75, 1.0, 1.25, 1.5, 1.75, 2.0))+
  theme_bw()

distrib_famosos <- distrib_famosos %>% 
  mutate(bilheteria_us = bilheteria_us*1000000000)

ggsave("g_bloxpot_filmes.png", plot = g_bloxpot_filmes)




