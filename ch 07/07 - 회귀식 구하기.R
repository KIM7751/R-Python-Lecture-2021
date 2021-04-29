gal <- read.csv("C:\\Workspace\\R\\Galtons Height Data.csv")
str(gal)
glimpse(gal)

gal.se <- gal %>%
         filter(Gender == 'M') %>%
    summarise(Father = Father * 2.54,
              Son = Height * 2.54)
gal.sel <- round(gal.se,1)

height_model <- lm(Son ~ Father, data = gal.sel)
height_model # Son = 0.4487 *Father + 97.0145
coef(height_model)

plot(gal.sel)
abline(height_model, col = 'red', lwd=2)
summary(height_model)


lm2 <- lm(Son ~ poly(Father,2), data = gal.sel) 
plot(gal.sel)
x <- seq(199.4, 157.5, length.out = 200) 
x 
y <- predict(lm2, data.frame(Father=x))
y
lines(x,y, col='purple', lwd=2)
abline(height_model, col='red', lwd=2)


summary(lm2)
