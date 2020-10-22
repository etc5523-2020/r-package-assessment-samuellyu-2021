library(shiny)
library(plotly)
library(DT)
library(shinythemes)
library(tidycovid19)
library(covdata)
library(tidyverse)
library(lubridate)
library(DT)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
options(scipen=999)

# wrangling --------------------------------------------------------------------------------------------

tidycovid <- download_merged_data(cached = TRUE, silent = TRUE) %>%
    filter(iso3c %in% c("IRL", "GBR")) %>%
    select(iso3c, date, recovered, soc_dist, mov_rest, pub_health, gcmr_retail_recreation, gcmr_grocery_pharmacy, gcmr_transit_stations, gcmr_workplaces, gcmr_residential) %>%
    rename(iso3 = iso3c)
covdata <- covnat %>%
    filter(iso3 %in% c("IRL", "GBR")) %>%
    left_join(tidycovid, by = c("date", "iso3"))
apple_mobility_covdata <- apple_mobility %>%
    filter(country %in% c("Ireland", "United Kingdom"))
world_map <- map_data("world") 
major_cities <- tibble(lat = c("55.953251", "51.481312", "54.597286", "52.486244","55.861147", "53.797419", "53.405472", "53.479147","53.349307", "51.897928", "53.274412", "52.661258", "51.507276"), 
                       lng = c("-3.188267","-3.180500", "-5.930120", "-1.890401", "-4.249989", "-1.543794", "-2.980539","-2.244745", "-6.261175", "-8.470581", "-9.049063", "-8.630208", "-0.12766"), 
                       region = c("Edinburgh","Cardiff","Belfast","Birmingham","Glasgow","Leeds","Liverpool","Manchester","Dublin","Cork", "Galway","Limerick", "London"),
                       country = c("GBR", "GBR", "GBR", "GBR", "GBR", "GBR", "GBR", "GBR", "IRL", "IRL", "IRL", "IRL", "GBR"),
                       population = c("482005", "335145", "280211", "1086000", "598830", "474632", "552267", "510746", "1388000", "124391", "79934", "194899", "8982000"))

cases_deaths_per_100k <- covdata %>%
    mutate(cases_per_100k = (cases/pop)*100000,
           deaths_per_100k = (deaths/pop)*10000,
           cu_cases_per_100k = (cu_cases/pop)*100000,
           cu_deaths_per_100k = (cu_deaths/pop)*100000,
           log_cu_cases = log10(cu_cases),
           log_cases = log10(cases),
           log_cu_deaths = log10(cu_deaths))

cases_uk_long <- cases_deaths_per_100k %>%
    filter(iso3 == "GBR",
           date >= "2020-01-31") %>% #updated the date to be day before first case
    mutate(days_from_1st_case = row_number(),
           days_from_1st_case = as.numeric(as.character(days_from_1st_case))) %>%
    select(date, iso3, cu_cases, cu_cases_per_100k, deaths_per_100k, cu_deaths_per_100k, cases, 
           cu_deaths, deaths, cases_per_100k, deaths_per_100k, log_cu_cases, log_cases, log_cu_deaths, 
           days_from_1st_case, soc_dist, mov_rest, pub_health) 


cases_irl_long <- cases_deaths_per_100k %>%
    filter(iso3 == "IRL",
           date >= "2020-03-01") %>% 
    mutate(days_from_1st_case = row_number(),
           days_from_1st_case = as.numeric(as.character(days_from_1st_case))) %>%
    select(date, iso3, cu_cases, cu_cases_per_100k, deaths_per_100k, cu_deaths_per_100k, 
           cases, cu_deaths, deaths, cases_per_100k, deaths_per_100k, log_cu_cases, log_cases, 
           log_cu_deaths, days_from_1st_case, soc_dist, mov_rest, pub_health) 

cases_uk_irl <- rbind(cases_uk_long, cases_irl_long) %>%
    mutate(details = glue::glue("<br><b>Date: {date}
                          <b>Soc_dist: {soc_dist}
                          <b>Mov_rest: {mov_rest}
                          <b>Pub_health: {pub_health}")) %>%
    rename(`Cumulative Confirmed Cases` = cu_cases,
           `Cumulative Confirmed Cases per capita, 100,000` = cu_cases_per_100k,
           `Daily Death Total per capita, 100, 000` = deaths_per_100k,
           `Cumulative Death per capita, 100,000` = cu_deaths_per_100k,
           `Daily Confirmed Cases` = cases,
           `Cumulative Deaths` = cu_deaths,
           `Daily Confirmed Deaths` = deaths,
           `Daily Confirmed Cases per capita, 100,000` =  cases_per_100k,
           `Log of Cumulative Confirmed Cases` = log_cu_cases,
           `Log of Daily Confirmed Cases` = log_cases,
           `Log of Cumulative Deaths` = log_cu_deaths,
           `Social distancing measures` = soc_dist,
           `Movement Restrictions` = mov_rest,
           `Public Health Measures` = pub_health)

table_setup <- cases_uk_irl %>%
    mutate(month = month(date),
           month_label = month(date, label = TRUE, abbr = TRUE)) 

apple_maps_major_cities <- apple_mobility_covdata %>%
    left_join(major_cities, by = "region") %>%
    select(-country.y) %>%
    rename(country = country.x) %>%
    mutate(lat = as.numeric(lat),
           population = as.numeric(population),
           lng = as.numeric(lng),
           Details = case_when(
               country == "United Kingdom" ~ glue::glue("<br><b>City: {region}
                          <b>Country: {sub_region}, {country}"),
               country == "Ireland" ~ glue::glue("<br><b>City: {region}
                          <b>Country:{country}"))) %>%
    filter(region %in% c("Edinburgh","Cardiff","Belfast","Birmingham","Glasgow","Leeds",
                         "Liverpool","Manchester","Dublin","Cork", "Galway","Limerick", "London"))


#ui ----------------------------------------------------------------------------------------------------

ui <- fluidPage(theme = shinytheme("yeti"),
    navbarPage(title = "Covid19: The Battle of Independence",
               tabPanel("About",
                        br(),
                        h1("About: The Battle of Independence"),
                        br(),
                        tags$br("The application: Covid19: The Battle of independence has been created and developed by Samuel Lyubic in order to allow for comparison of the impact of corona virus as well as the government response from Ireland and the United Kingdom"),
                        br(),
                        tags$br("The global pandemic that is coronavirus has furthered the long standin discussion for complete Irish independence. 
                                Ireland is split into two states - The republic of Ireland and Northern Ireland, with the help of the current pandemic 
                                there is now a burning case study for the operations of both governments with coronavirus being the proxy for the ability 
                                for Ireland to stand united against the benefits and of Northern Ireland remaining as part of the UK and Ireland stay divided. 
                                When the corona virus began to run rampid in Europe the Irish government offered clarity and clear instructions to combat the virus 
                                and acted quickly and decisively to implent a range of restrictions and health measures in order to get ontop of the highly contagious virus, as presented in Figure (Mullally,U(2020))."),
                        br(),
                        tags$br("This app aims to provide the user with an interactive and insightful tool for compartive analysis of the impact of coronavirus and response from each government")),
               tabPanel("Cases, Deaths and Government Intervention",
                        h1("Cases, Deaths and Government Intervention"),
                        h3("A comparitive analysis of the cases, deaths and different forms of government intervention between Ireland and Great Britain (GBR)"),
                        br(),
                        sidebarLayout(
                            sidebarPanel(
                                titlePanel(h4("Selection tools")),
                                br(),
                                selectInput(inputId = "case_type", label = "Please select the type of count to compare",
                                            choices = c("Cumulative Confirmed Cases",
                                                        "Cumulative Confirmed Cases per capita, 100,000",
                                                        "Daily Death Total per capita, 100, 000",
                                                        "Cumulative Death per capita, 100,000",
                                                        "Daily Confirmed Cases",
                                                        "Cumulative Deaths",
                                                        "Daily Confirmed Deaths",
                                                        "Daily Confirmed Cases per capita, 100,000",
                                                        "Log of Cumulative Confirmed Cases",
                                                        "Log of Daily Confirmed Cases",
                                                        "Log of Cumulative Deaths",
                                                        "Social distancing measures",
                                                        "Movement Restrictions",
                                                        "Public Health Measures"),
                                            selected = "Log of Cumulative Confirmed Cases"),
                                tags$br("The seletion input offers a range of different compartive counts that will be visualised on the figure in the main page"),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                dateInput_range(inputId = "date", label = "Date range of covid results for chosen date range",
                                                date = cases_uk_irl$date),
                                tags$br("The date range selection will adjust the date range of observations for the counts visualised in the figure and the corresponding government intervention for that date period."),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                checkboxGroupInput(inputId = "country", label = "Country to display in the government intervention table",
                                                   choices = c("GBR", "IRL"),
                                                   selected = c("GBR", "IRL")),
                                tags$br("Both or single countries can be selected and displayed in the government intervention table by clicking the corresesponing box."),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                            ),
                            mainPanel(
                                br(),
                                h2("Covid Count and Deaths Analysis"),
                                plotlyOutput("cases_uk_irl"),
                                tags$br("The above figure visualises the chosen variables with the date range on the x axis and the figures relating to the variable selected on the y axis. 
                                        This figure is interactive, by hovering over the points of the plot you will see the specific information regarding: 
                                        date and number of restriction/government measures in place for each nation. Furthermore, the figure offers the ability of zooming in, zooming out (by double clicking) and by clicking
                                        the country names in the legend, titled Countries, the plot can be isolated for one country."),
                                br(),
                                h2("Government Intervention"),
                                tabsetPanel(
                                    id = 'measures_data',
                                    tabPanel("Social Distancing Measures", dataTableOutput("measures_pct1")),
                                    tabPanel("Movement Restrictions", dataTableOutput("measures_pct2")),
                                    tabPanel("Public Health Policy", dataTableOutput("measures_pct3"))),
                                br(),
                                tags$br("The table above displays a grouped percentage breakdown of the number of measures, restriction and public policy enacted by both governments, with a focus on 
                                        social distancing measures, movement restrictions and public health policy. Each type of measurehas been grouped along the horizontal pane. Each of the three measures can be accessed by clicking on their corresponding name at the top of the table.
                                        The table is interactive by clicking on the ticks at the top of each box the order of the table can be defined by the variable of choosing."),
                                br()))),
               tabPanel("Movement analysis",
                        h1("Movement Analysis"),
                        h3("A comparative analysis of the impact coronavirus has had on overall mobility as well as the different forms of transport for the residents of each country"),
                        br(),
                        sidebarLayout(
                            sidebarPanel(selectInput(inputId = "location", label = "Select which country to observe?",
                                                     choices = c("United Kingdom", "Ireland"), 
                                                     selected = "Ireland"),
                                         tags$br("The above input will produce a map of the chosen country which will highlight the major cities of each country by the size of their population"),
                                         br(),
                                         br(),
                                         br(),
                                         br(),
                                         selectInput(inputId = "city", label = "Which major city would you like to assess",
                                                     choices = ""),
                                         tags$br("The above input allows for manual selection of the city that will be produced in the corresponding plot showing the change in mobility across the pandemic over a range of forms of transport")),
                            mainPanel(
                                h2("Country Map"),
                                h4("The map of the selected country will appear below displaying the locations of their major cities. Each cities population has been coded to represent the size of the point"),
                                plotlyOutput("map"),
                                tags$br("The map allows for click interaction whereby, by clicking on the point of the city of choice the corresponding mobility data will be visualised in the figure below."),
                                br(),
                                h3("Change in mobility"),
                                plotlyOutput("movement_plot"),
                                br(),
                                tags$br("The above figure displays the movement trends of residents in the following three forms of transport: driving, transit and walking, as recorded by the apple maps who provide an acitvity score that is based off of the 
                                apple maps usage with regards to the relative volume of requested directions for driving compared to a baseline volume on January 13th, 2020. The activity score is indeced at 100 thus any deviation around the index demonstrates a percentage change from the base line date. 
                                         The figure displays interactive qualities whereby by each mode of transport can be isolated by clicking on it")))),
               tabPanel("References and acknowledgements",
                        h1("Citations"),
                        tags$br("Healy, Kieran. 2020. Covdata: COVID-19 Case and Mortality Time Series. http://kjhealy.github.io/covdata"),
                        tags$br(),
                        tags$br("Grolemund, Garrett, and Hadley Wickham. 2011. “Dates and Times Made Easy with lubridate.” Journal of Statistical Software 40 (3): 1–25. http://www.jstatsoft.org/v40/i03/.)"),
                        tags$br("Gassen, Joachim. 2020. Tidycovid19: Download, Tidy and Visualize Covid-19 Related Data."),
                        tags$br("Grolemund, Garrett, and Hadley Wickham. 2011. “Dates and Times Made Easy with lubridate.” Journal of Statistical Software 40 (3): 1–25. http://www.jstatsoft.org/v40/i03/."),
                        tags$br("Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy D’Agostino McGowan, Romain François, Garrett Grolemund, et al. 2019. “Welcome to the tidyverse.” Journal of Open Source Software 4 (43): 1686. https://doi.org/10.21105/joss.01686"),
                        tags$br("Mullally, U. 2020. How Coronavirus Is Spurring the Cause of a United Ireland. https://www.theguardian.com/commentisfree/2020/may/02/coronavirus-united-ireland-pandemic-."),
                        tags$br("Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework for R. R package version 1.5.0. https://CRAN.R-project.org/package=shiny"),
                        tags$br("Winston Chang (2018). shinythemes: Themes for Shiny. R package version 1.1.2. https://CRAN.R-project.org/package=shinythemes"),
                        tags$br("C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and shiny. Chapman and Hall/CRC Florida, 2020."),
                        tags$br("Yihui Xie, Joe Cheng and Xianying Tan (2020). DT: A Wrapper of the JavaScript Library 'DataTables'. R package version 0.15. https://CRAN.R-project.org/package=DT"),
                        tags$br("Pebesma, E., 2018. Simple Features for R: Standardized Support for Spatial Vector Data. The R Journal 10 (1), 439-446, https://doi.org/10.32614/RJ-2018-009"),
                        tags$br("Andy South (2017). rnaturalearth: World Map Data from Natural Earth. R package version 0.1.0. https://CRAN.R-project.org/package=rnaturalearth"),
                        tags$br("Andy South (2017). rnaturalearthdata: World Vector Map Data from Natural Earth Used in 'rnaturalearth'. R package version 0.1.0. https://CRAN.R-project.org/package=rnaturalearthdata")
               
               )
    ))
    
#server ------------------------------------------------------------------------------------------------
    
server <- function(input, output, session) {
    
    new_date <- reactive({ 
        filter(cases_uk_irl, between(date, input$date[1], input$date[2]))})
    
    output$cases_uk_irl <-renderPlotly({ 
        
        plot_cases <- new_date() %>%
            ggplot(aes(x = date,
                       y = get(input$case_type),
                       color = iso3,
                       label = details)) +
            geom_line() + 
            theme_minimal() +
            labs(x = "Date",
                 y = input$case_type,
                 color = "Country") +
            scale_x_date(date_breaks = "month", date_labels = "%b",
                             date_minor_breaks = "week") +
            theme(plot.title.position = "plot",
                  plot.margin = margin(10, 10, 10, 10),
                  axis.line = element_line(colour = "black"),
                  panel.background = element_rect(fill = "transparent"),
                  plot.background = element_rect(fill = "transparent", color = NA),
                  legend.position = "bottom")
          
        
        ggplotly(plot_cases) %>% 
            config(displayModeBar = F) 
        
        })
    
    reactive_table <- reactive({
        req(input$date)
        req(input$country)
        filter(table_setup, between(date, input$date[1], input$date[2]),
               iso3 == input$country)})
    
    output$measures_pct1 <- DT::renderDataTable({
        
        soc_dist <- reactive_table() %>%
            group_by(month, month_label, iso3, `Social distancing measures`) %>%
            summarise(prop = n()) %>%
            mutate_all(~replace(., is.na(.), -1)) %>%
            mutate(measures_group = 
                       case_when(`Social distancing measures` <= 0 ~ "No Restrictions (-4 to 0) (%)",
                                 `Social distancing measures` >= 0 & `Social distancing measures` <= 4 ~ "1 to 4 (%)",
                                 `Social distancing measures` >= 5 & `Social distancing measures` <= 8 ~ "4 to 8 (%)",
                                 `Social distancing measures` >= 9 & `Social distancing measures` <= 12 ~ "9 to 12 (%)",
                                 `Social distancing measures` >= 13 & `Social distancing measures`<= 16 ~ "12 to 16 (%)",
                                 `Social distancing measures` >= 17 ~ "17 or more (%)")) %>%
            mutate(proportion = round(((prop/sum(prop))*100), 2)) %>%
            ungroup()
        soc_dist_tab <- data_wrangle(soc_dist)
        
        dt_styler(soc_dist_tab, "Country", "IRL", "GBR", "#dcfbdc", "#fedddd", 7)
        
    })
    
    output$measures_pct2 <- DT::renderDataTable({
        
        mov_rest <- reactive_table() %>% 
            group_by(month, month_label, iso3, `Movement Restrictions`) %>%
            summarise(prop = n()) %>%
            mutate_all(~replace(., is.na(.), -1)) %>%
            mutate(measures_group = 
                       case_when(`Movement Restrictions` <= 0 ~ "No Restrictions (-2 to 0) (%)",
                                 `Movement Restrictions` > 0 & `Movement Restrictions` <= 2 ~ "1 to 2 (%)",
                                 `Movement Restrictions` >= 3 & `Movement Restrictions` <= 4 ~ "4 to 6 (%)",
                                 `Movement Restrictions` >= 5 & `Movement Restrictions` <= 6 ~ "7 to 9 (%)",
                                 `Movement Restrictions` >= 7 & `Movement Restrictions` <= 8 ~ "12 to 16 (%)")) %>%
            mutate(proportion = round(((prop/sum(prop))*100), 2)) %>%
            ungroup() 
        mov_rest_tab <- data_wrangle(mov_rest)
        
        dt_styler(mov_rest_tab, "Country","IRL", "GBR", "#dcfbdc", "#fedddd", 7)
    })
    
    output$measures_pct3 <- DT::renderDataTable({

        pub_h_tab <- reactive_table() %>%
            group_by(month, month_label, iso3, `Public Health Measures`) %>%
            summarise(prop = n()) %>%
            mutate_all(~replace(., is.na(.), -1)) %>%
            mutate(measures_group = 
                       case_when(`Public Health Measures` <= 0 ~ "No Measures (%)",
                                 `Public Health Measures` >= 0 & `Public Health Measures` <= 4 ~ "1 to 4 (%)",
                                 `Public Health Measures` >= 5 & `Public Health Measures` <= 8 ~ "5 to 8 (%)",
                                 `Public Health Measures` >= 9 & `Public Health Measures` <= 12 ~ "9 to 12 (%)",
                                 `Public Health Measures` >= 13 & `Public Health Measures` <= 16 ~ "13 to 16 (%)",
                                 `Public Health Measures` >= 17 ~ "17 or more (%)"))%>%
            mutate(proportion = round(((prop/sum(prop))*100), 2)) %>%
            ungroup() 
        pub_health <- data_wrangle(pub_h_tab)
        
        dt_styler(pub_health, "Country","IRL", "GBR", "#dcfbdc", "#fedddd", 7)
    })
    
    
    world_reactive <- reactive({ne_countries(type = "countries", 
                                             country = input$location, 
                                             scale = "medium", returnclass = "sf")})
    
    apple_maps_country <- reactive({
        apple_maps_major_cities %>%
            filter(country == input$location)
    })
    
    output$map <- renderPlotly ({
        
        plot_map <-ggplot(data = world_reactive()) +
            geom_sf() +
            geom_point(data = apple_maps_country(),
                       aes(x = lng,
                           y = lat,
                           color = region,
                           size = (population/1000000),
                           label = Details)) +
            labs(color = "Major Cities",
                 size = "Major Cities") +
            theme_void() + 
            theme(axis.line = element_blank(), 
                  panel.background = element_rect(fill = "transparent"),
                  plot.background = element_rect(fill = "transparent", color = NA)) 
            
        
        
        ggplotly(plot_map, source = "A") %>% 
            config(displayModeBar = F)
    })
    
    observeEvent(input$location, {
        updateSelectInput(session, "city",
                          choices = filter(apple_maps_major_cities, country == input$location)$region)
        
    })
    
    observeEvent(event_data("plotly_click"), {
        click_df <- event_data("plotly_click")
        region_name <- filter(apple_maps_major_cities, lng == click_df$x, lat ==click_df$y) %>%
            pull(region)
        updateSelectInput(session, "city", selected = region_name)
    })
    
    major_cities_only <- reactive({apple_maps_major_cities %>%
            filter(region == input$city)
        })
    
    output$movement_plot <- renderPlotly({
        
        major_cities <- major_cities_only() %>%
            ggplot(aes(x = date,
                       y = score,
                       color = transportation_type)) +
            geom_line() +
            geom_hline(yintercept = 100, color = "black") +
            theme_classic() +
            theme(plot.title.position = "plot",
                  plot.margin = margin(10, 10, 10, 10),
                  axis.line = element_line(colour = "black"),
                  panel.background = element_rect(fill = "transparent"),
                  plot.background = element_rect(fill = "transparent", color = NA)) +
            labs(x = "Date",
                 y = "Apple Movement Score, Indexed 100, (%)",
                 color = "Transportation")
        
        ggplotly(major_cities, source = "B") %>% 
            config(displayModeBar = F) 
    })
}

    


# Run the application 
shinyApp(ui = ui, server = server)
