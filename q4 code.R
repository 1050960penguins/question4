#q 4 code


setwd("~/Penguin_projects")
penguins_raw <- read.csv("/Users/rozabailey/Penguin_projects/data_raw/penguins_raw.csv")
#change to your working directory etc

penguins_clean1 <- penguins_raw %>%
  select(-starts_with("Delta")) %>%
  select(-Comments)%>%
  clean_names()
#cleaning the data with a pipe to a new variable called penguins_clean1

cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
#creating a colour blind friendly palette i can use for my figure

penguins_clean1
#linear model 
penguin_mod1 <- lm(body_mass_g ~ flipper_length_mm, penguins_clean1)


bodymass_flipper_plot<- ggplot(penguins_clean1, aes(x= body_mass_g, y=flipper_length_mm, colour = species))+
  geom_point()+
  scale_colour_manual(values=cbPalette)+
  theme_bw()+
  geom_smooth(method= "lm", col = "#009E73")+
  labs(x= "Body Mass (g)", y = "Flipper Length (mm)")

bodymass_flipper_plot
#plotting a scattergraph of body mass vs flipper length with a linear model overlayed


library(svglite)
svglite("figures/fig1_vector.svg", 
        width = 5.9, height = 5.9)
bodymass_flipper_plot
dev.off()

# Render the svg into a png image with rsvg via magick
img <- magick::image_read_svg("figures/fig1_vector.svg", width = 1080)
magick::image_write(img, 'fig1_vector.png')
img

#saved as a vector and displayed as a png
