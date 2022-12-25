library(officer)
library(magrittr)
library(flextable)

# load template
pres_new <- read_pptx(path = "template.pptx") %>%
  #take the slide named Title slide 1 from slide master name
  add_slide(layout = "Title Slide") %>%
  # add title with location type
  ph_with(value = "Hello World"
          , location = ph_location_type(type = "ctrTitle")) %>%
  # add content to another place holder
  ph_with(value = paste0("Hello World | ",Sys.Date()) 
          , location = ph_location_type(type = "subTitle")) %>%
  # do the same as above, e.g. take the slide with name Agenda 2
  add_slide(layout = "Section Header") %>%
  ph_with(value = "Agenda:", 
          location = ph_location_type(type = "title")) 

# for each issue create separate slide with table of data and modifies table to fit slides
for (i  in c(1:10)) {
  
  df1 <- head(mtcars)

  df <-  autofit(flextable(df1)) %>%
    bg(bg = "#280071", part = "header") %>%
    color(color = "white", part = "header") %>% 
    hline_top(part = "all", border = fp_border(color ="grey")) %>%
    hline_bottom(part = "all", border = fp_border(color ="grey")) %>%
    vline(border = fp_border(color = "grey")) %>%
    hline(border = fp_border(color = "grey"), part = "all") 
  
  pres_new <- pres_new %>%
    add_slide() %>%
    ph_with(value = paste0("MTCARS SLIDE | ", i)
            , location = ph_location_type(type = "title")) %>%
    ph_with(value = df, location = ph_location_label(ph_label = "Content Placeholder 2")) 
  
}
# save as file
print(pres_new, target = "test.pptx")

# to see full content of your slide master
layout_summary(read_pptx(path = "template.pptx"))
# to see place holder labels and type for particular slide
layout_properties(pres_new, layout = "Title Slide")
