#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(ggplot2)

plot_summary <- function(draw_summary){
  
  draw_summary$level <- factor(draw_summary$level, levels=c("0.66 Level","0.95 Level"),ordered = T)
  
  plot <- ggplot(draw_summary, aes(y = key,x=Estimate,shape="Estimate"))+
    geom_point(show.legend = T,size=3)+
    geom_segment(aes(y=key,yend=key,x=min,xend=max,linewidth=level))+
    scale_discrete_manual("linewidth", values = c("0.95 Level"=0.75, "0.66 Level"=1.5))+
    labs(x="Estimate", y="", title="")+
    guides(linewidth = guide_legend(title="",
                                    nrow = 2, 
                                    byrow = TRUE, 
                                    override.aes = list(shape = c(NA), linetype = c("solid", "solid"))),
           shape=guide_legend(title="")) +
    theme(plot.title = element_text(hjust=0.5))
  
  return(plot)
  
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  model_summary <- readr::read_csv("./data/full_model_summary.csv")
  
  
    output$distPlot <- renderPlot({
      
      subset <- model_summary$type==input$params
      print(input$params)
      print(input$vars)
      
      
        if (input$params == 'Project Random Effects'){
        subset <- model_summary$type==input$params & model_summary$variable==input$vars
        }

      
      
      plot_summary(model_summary[subset,])


    },height = 700, width = 800)

})
