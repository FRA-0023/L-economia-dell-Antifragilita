setwd("C:/Users/3003f/Downloads")
rm(list = ls())
library(tidyverse)
library(scales)
library(gridExtra)

#salaries2025 <- as_tibble(read.csv("DataScience_salaries_2025.csv", 
#                                   header = TRUE, sep = ","))

salaries2028 <- as_tibble(read.csv("salaries.csv", 
                                   header = TRUE, sep = ","))


#### 3. Lista di parole da rimuovere ####
unwanted_words <- c("Entry", "Level", "Junior", "Intermediate", "A",
                    "Scm", "Ms", "Career", "Senior", "Assistant",
                    "Associate", "Ar", "Denver", "Manager", "Director",
                    "Lead", "Specialist", "Or", "Liaison", "Trainee",
                    "Intern", "Temporary", "Part-time", "Employee", "Svp",
                    "SVP", "Full-time", "Contract", "Freelance", "Title",
                    "Workday", "Opportunity", "1st", "Works", "And",
                    "Remote", "Hybrid", "Fulltime", "Compensation", "Salt",
                    "Lake", "City", "Ut", "Vice", "President",
                    "F35","Preferred","Administrator","Coordinator",
                    "Walmart", "D365", "Campus", "Team", "Carolina",
                    "Oh", "Leadership", "Years", "Co", "Fp",
                    "Assoc", "Minimum", "For", "Hands", "Nyc",
                    "W", "Gc", "Chicago", "Job", "Houston",
                    "California", "Master", "Of", "North", "South",
                    "Professional", "Journeyman", "York", "America", "Fl",
                    "Los", "Angeles", "With", "Workplace", "Metrics",
                    "Departmental", "Summer", "Sponsored", "La", "Canada",
                    "W2", "Sc", "Beach", "Tn", "Wi",
                    "Wpoly", "Vp", "Maryland", "Hilton", "Park",
                    "Telework", "Midlevel", "Mid", "Va", "Work",
                    "Seattle", "Remotehybrid", "S", "Wfh", "Role",
                    "Local", "Dc", "Usc", "Term", "One",
                    "Intel", "Pay", "Fractional", "Koreanenglish", "Small",
                    "Cogito", "Epic", "Iam", "Firm", "Water",
                    "Foundation", "Pro", "Part", "Time", "Nam",
                    "Las", "Vegas", "Chief", "s", "Contracting",
                    "Valley", "Excellence","External", "Austin", "Category",
                    "Region", "Dallas", "Store", "Americas", "Internal",
                    "Days", "Competitive", "San", "Parttime", "Expert",
                    "Field", "Must", "High", "Georgetown", "Ft",
                    "New", "Full", "Fte", "Entrylevel", "Base",
                    "Enrollment", "Personal", "iiiiii", "Qa", "Exp",
                    "Early", "Workforce", "Day", "Performance", "Center",
                    "Sr", "Gis", "Spanish", "Owner", "Experience",
                    "Graduate", "User", "Fulfillment", "Google", "Company",
                    "Regional", "Division", "D", "Ct", "Area",
                    "District", "Complex", "Multi", "Resort", "General",
                    "apple", "East", "West", "Partner", "Placement",
                    "Liason", "Texas", "Domain", "Orlando", "Atlanta",
                    "International", "Group", "State", "Member", "Global",
                    "Bilingual", "Md", "Tx", "Ny", "Na",
                    "Il", "Ownerbusiness","Levels", "Hybridremote", "Focus",
                    "Iiiiii", "Edi", "Staff", "Amazon", "Fellow",
                    "Sector", "Ohio", "Tech", "Usa", "Innovation",
                    "Command", "Mn", "Secretary", "Head", "Executive",
                    "Industry","Nonprofit","Profit","Divisional","Property",
                    "Interim", "Non", "Locations", "Nc", "Franchise",
                    "Iiiii", "Provider", "Subject", "Audit", "Integrity",
                    "Initiatives", "World", "Omnichannel", "Within", "Inc",
                    "Fall", "Principal", "Apple", "Enterprise", "Charlotte",
                    "Line", "Writer", "Avp", "Pega", "Washington",
                    "Lab", "Laboratory", "Middle", "Validation", "United",
                    "Ledger", "Ing", "Experienced", "E2d", "C2c",
                    "Boston", "Looking", "charlotte", "Opening", "St",
                    "Fully", "Us", "Union", "Minneapolis", "Land",
                    "Benefits", "Distinguished", "Month","Matter",
                    "Tools","Link","Capture","Tier","Future","Er",
                    "Az","AZ","Immediate","NJ","Temp","Coe","svp",
                    "Success","Usds","Resource","Gen","Id","Services",
                    "Outsourced","Plant","Siri","Labs","Start","Tiktok",
                    "Openings", "Readiness", "Sports", "Spec", "Multiple",
                    "Avaiable", "Positions", "Survey", "Service",
                    "Reporting","Technology", "Support", "Solutions",
                    "Organization", "Community","Consumer", "Impact",
                    "Client", "Agency", "Unit","Admin", "Microsoft",
                    "microsoft", "Technologies", "Fusion","Option",
                    "Permanent", "Private", "Public", "Bricks", "Leader",
                    "Practice", "Drug", "Info", "Foreign", "Operating",
                    "Desk", "Deal", "Direct", "Hire", "Wa","Dept", "Fs",
                    "Fsp", "Ts", "Asst","Track", "Shared", "Special",
                    "Change", "Order","Plan", "Fixed", "Review", "Value",
                    "Grade","Location", "Call", "Mi", "Ga", "Nj",
                    "Top", "Objects", "Active", "Mission", "Req",
                    "Required", "Requirements", "Open", "Core", "Coop",
                    "s", "Corp", "Test", "S", "Rd","Card", "Ca", "Mgr",
                    "Bus", "Position","Specialty", "Records", "Insight",
                    "Team", "Startup","Structured", "Future", "Decision",
                    "Contact", "Board","State", "Vision", "Trend",
                    "Customer", "Transformation","Document", "Knowledge",
                    "End", "Reference", "Voice","Video", "Game", 
                    "Rotational", "Cleared", "Citizen","Orsa", "Tampa",
                    "Based", "public", "Social","Staff", "Solution",
                    "Leadership", "Communication", "Pipeline","Tools",
                    "Device", "Hardware", "Assistant", "System",
                    "Platform", "Quality", "Applied", "People", "Rport",
                    "rport", "Continuity", "Collection", "Istitutional",
                    "Continuous","Capabilities", "Ihm", "Inventory",
                    "Communications", "Advanced","Identity", "Relations",
                    "Schedule", "Products", "Implementation","Consultant",
                    "Technical", "Capacity", "Avaiable", "Material",
                    "Improvement", "Source", "Population", "Maintenance",
                    "Migration","Federal", "Department", "Governance",
                    "Functional", "Consulting","Talent", "Planning",
                    "Integration", "Program", "Channel","Flexible",
                    "Planner", "Servicing", "Reliability", "Eligible",
                    "Technician", "Retail", "Construction", "Affairs",
                    "Trust","Space", "Student", "College", "University",
                    "Information","Control", "Home", "National", "Onsite",
                    "Clearance","Compliance", "Institute", "Programs",
                    "School", "Officier","Candidates", "Civil", "Family",
                    "Child", "Discovery","Online", "Labor", "Force",
                    "Automotive", "Hospitality","goverment", "Education",
                    "Pharmacy", "Medical", "Military","Healthcare", 
                    "Health", "Insights", "Automation", "Food",
                    "Academic", "Advancement", "Prevention", "Reports",
                    "Dir","Gtm", "Branch", "Certified", "Casino",
                    "Patient","Dealership", "Nursing", "Party", "Live",
                    "Critical","Annotation", "Lifecycle", "Goverment",
                    "Military", "Automotive","Gaming", "Aviation",
                    "Restaurant", "Loyalty", "Ecomm","Ecommerce",
                    "Merchandising", "Legislative", "Server", "Clinical",
                    "Digital", "App", "Application", "Asset", "Supervisor",
                    "Available", "Mobile", "Virtual", "Integrated",
                    "Central","Travel", "Hotel", "Hospital", "Scheduler",
                    "Facility","Partnerships", "Recovery", "Straming",
                    "Infra", "Sda","Facilities", "Bureau", "officier",
                    "Collections", "Web","Integrator", "Citizens", 
                    "Vehicle", "Merchandise", "Case","Onboarding",
                    "Climate", "Post", "Ehr", "Dshs","Reimbursement",
                    "Electronic", "Sys", "Utilities", "Purchasing",
                    "Electrical", "Flight", "Oversight", "Auto", "Exempt",
                    "Rcm", "Representative", "Contractor", "Pa",
                    "Evaluation","Stack", "Sme", "Mechanical", "Centers",
                    "Scheduling","Measurement", "Sourcing", "Fleet",
                    "Integrations", "Adjustment","Industrial", "Execution",
                    "Environmental", "Enablement", "Demand","Applications",
                    "Product","Institutional", "Sustainability", 
                    "Operation","States","Physical","Apps",
                    "Guidewire","Fellowship","S","Shift",
                    "Procurement","County","Quantitative","Erp","Loss",
                    "Fms","s","Plm","Gcp","Life","Geospatial","Design",
                    "Modeler","Site","Supplier","Officer","Transfer",
                    "Scrum","Pmo","Payroll","Cycle","Advisor","Office",
                    "Conversational","Configuration","S","Navy",
                    "Advisory","Ambulatory","Energy","Growth",
                    "Designer","Storage","Dynamics","Access","Mdm","Gas",
                    "Court","Pc","Ci","Deputy","Commerce","Ma",
                    "Medicine","Media","Ship", "Merchant","Medicare",
                    "Controls","Streaming","Government","Engagement",
                    "Monetization","Revenue","Signal","Process",
                    "Testing","Medicaid","Real","Manufactoring",
                    "Servicenow","Visual","Materials","Income",
                    "Trade","Estate","Expense","Training","Trainer",
                    "Crime","Crimes","Commissions","Venture",
                    "Relationship","Cost","Billing","Sentinel",
                    "Fico","Equipment","Ventures","Secret","Cancer",
                    "Lease","Tax","Peoplesoft","Oncology","Cancer",
                    "Sap","Supply","Chain","Manufactoring","Cash",
                    "Tester","Report","Securities",
                    "Budget","Distribution","Care","Fraud",
                    "Policy","Contracts","Capital","Lending","Insurance",
                    "Administration","Infrastructure","Polygraph",
                    "Network","Distribution","Operational","Transportation",
                    "Natural","Processing","Optimization","Computing",
                    "Computer","Protection","Trading","Agile","Payment",
                    "Systems","Risk","R","Sec","Contract",
                    "Oracle","Power_Bi","Claims","Law","Wealth",
                    "Derivatives","Debt","Loan",
                    "Assets","Netsuite","Sharepoint","Cognos",
                    "Monitoring","Justice","Valuation",
                    "Payable","C","r","Networking","Credit","Bank","Aws",
                    "Sas","Strategy","Snowflake","Biology",
                    "Mortgage","Excel","Liquidity","Spark","Azure",
                    "Delivery","Portfolio","Software","Strategic",
                    "Startegist","Grant","Corporate","Fiscal",
                    "Grants","Manufacturing","Treasurers","Treasurer",
                    "Logistics","Surveillance","Salesforce","Equity",
                    "Acquisitions","Acquisition","Simulation","Privacy",
                    "Forecasting","Investigation","Bioinformatics",
                    "Tssci","Aml","Banking","Regulatory","Clerk",
                    "Safety","Dod","Surveillance","Threat","Defense",
                    "Soc","Dhs","Testing","Funds","Fund","Net",
                    "Poly","Assessment","Strategist","Itsm",
                    "Crm","Python","Sql","Java","Production",
                    "Algorithm","Algorithms","Computational","Informatics",
                    "Informatica","Predictive","Autonomous","Mining",
                    "Legal","Robotics","Imaging","Investigation",
                    "Investigations","Modeling","Cloud","Big",
                    "Tableau","Net","Payments","Operations",
                    "Forensic","Brand","Content","Pricing",
                    "Visualization",
                    "Commercial","Investments","Architect","Saas",
                    "Architecture","Market","Markets","Advertising",
                    "Power","Powerbi","Warehouse","Research","Search",
                    "Bookkeeping","Bookkeeper","Rpa",
                    "Automation", "Ba")

#### 4 Skill function ####
library(tidyverse) 
clean_and_split_job <- function(data) {
  keywords <- c("Accountant", "Controller", "Manager", "Finance",
                "Financial", "Assistant", "CFO","Critical","Auditor",
                "Accounting","Programmer","Developer","Business",
                "Office", "Budget", "Data", "Analyst", "Consultant",
                "Engineer","Critical", "Post","post","Ai","AI",
                "Scientist","Research","Analyst")
  
  # Funzione per separare parole che iniziano con una keyword
  split_keywords <- function(job) {
    for (kw in keywords) {
      if (startsWith(job, kw)) {
        # Rimuovi la keyword e conserva la parte successiva
        rest_of_word <- substr(job, nchar(kw) + 1, nchar(job))
        if (nchar(rest_of_word) > 0) {
          rest_of_word_split <- gsub("([a-z])([A-Z])", 
                                     "\\1 \\2", rest_of_word)
          return(c(kw, rest_of_word_split))
        }
      }
    }
    return(job)
  }
  
  remove_duplicate_words <- function(text) {
    words <- unlist(strsplit(text, " "))
    unique_words <- unique(words)
    result <- paste(unique_words, collapse = " ")
    return(result)
  }
  
  data %>%
    dplyr::select(ID, Job) %>%
    mutate(Job_Clean = str_replace_all(Job, "[-.;]", "")) %>%
    mutate(Job_Clean = str_replace_all(Job_Clean, "[^[:alnum:] ]", "")) %>%
    mutate(Job_Clean = str_replace_all(Job_Clean, "\\b(I|II|III|Sr|Jr|IV|V|Iiiiii)\\b", "")) %>%
    mutate(Job_Clean = str_replace_all(Job_Clean, "\\b\\d+\\b", "")) %>%
    mutate(Job_Clean = str_squish(Job_Clean)) %>%
    mutate(Job_Clean = str_split(Job_Clean, " ")) %>%
    unnest(Job_Clean) %>%
    mutate(Job_Clean = map(Job_Clean, split_keywords)) %>%
    unnest(Job_Clean) %>%
    mutate(Job_Clean = str_trim(Job_Clean),
           Job_Clean = str_to_title(Job_Clean)) %>%
    mutate(Job_Clean = recode(Job_Clean,
                              "Artificial" = "Ai",
                              "Generative" = "Ai",
                              "Anl" = "Analyst",
                              "Analysis" = "Analyst",
                              "Analytic" = "Analyst",
                              "Analytics" = "Analyst",
                              "Auditor" = "Accountant",
                              "Accounting" = "Accountant",
                              "Account" = "Accountant",
                              "Accounts" = "Accountant",
                              "Cpa" = "Accountant",
                              "Comptroller" = "Accountant",
                              "Models" = "Modeling",
                              "Model" = "Modeling",
                              "Bi" = "Intelligence",
                              "Businesses" = "Business",
                              "Economics" = "Economist",
                              "Economic" = "Economist",
                              "Bcba" = " Hr",
                              "Human" = "Hr",
                              "Behavioral" = "Hr",
                              "Behaviour" = "Hr",
                              "Behavior" = "Hr",
                              "Hcm" = "Hr",
                              "Hris" = "Hr",
                              "Resources" = "Hr",
                              "Recruiting" = "Hr",
                              "Rpa" = "Robotics",
                              "Wms" = "Warehouse",
                              "Mathematical" = "Mathematician",
                              "Research"="Researcher",
                              "Etl" = "Warehouse",
                              "Reinsurance" = "Insurance",
                              "Actuarial" = "Insurance",
                              "Assurance" = "Insurance",
                              "Doctoral" = "Professor",
                              "Phd" = "Professor",
                              "Cfo" = "Finance",
                              "Financial" = "Finance",
                              "Retirement" = "Finance",
                              "Underwriting" = "Finance",
                              "Controller" = "Finance",
                              "Treasury" = "Finance",
                              "Bursar" = "Finance",
                              "Fpa" = "Finance",
                              "Dev" = "Developer",
                              "Programmer" = "Developer",
                              "Backend" = "Developer",
                              "Programming" = "Developer",
                              "Platforms" = "Developer",
                              "Development" = "Developer",
                              "Fullstack" = "Developer",
                              "Devops" = "Developer",
                              "Compiler" = "Developer",
                              "Projects" = "Pm",
                              "Project" = "Pm",
                              "Mgmt" = "Management",
                              "Managing" = "Management",
                              "Managed"= "Management",
                              "Supervisory" = "Management",
                              "Warehousing" = "Warehouse",
                              "Housing" = "Warehouse",
                              "Ops" = "Operations",
                              #"Machine" = "Ml",
                              #"Learning" = "Ml",
                              "Investment" = "Investments",
                              "Cyber" = "Cybersecurity",
                              "Administrative" = "Administration",
                              "Vendor" = "Sales",
                              "Wholesale" = "Sales",
                              "Conversion" = "Sales",
                              "Seller" = "Sales",
                              "Receivable" = "Payable",
                              "Large" = "Llm",
                              "Language" = "Llm",
                              "Statistical" = "Statistics",
                              "Statistician" = "Statistics",
                              "Ads" = "Advertising",
                              "Ad" = "Advertising")) %>%
    filter(Job_Clean != "") %>%
    filter(!Job_Clean %in% unwanted_words) %>%
    mutate(Job_Clean = map_chr(Job_Clean, remove_duplicate_words)) %>%
    group_by(ID) %>%
    summarise(Job_Clean = paste(Job_Clean, collapse = " "), 
              .groups = 'drop')
}



#View(salaries2025)

salaries2025 <- salaries2025 %>%
  mutate(experience_level = case_when(
    experience_level == "EN" ~ "Junior",
    experience_level == "MI" ~ "Mid-Level",
    experience_level == "SE" ~ "Senior",
    experience_level == "EX" ~ "Lead",
    TRUE ~ experience_level))


salaries2025 <- salaries2025 %>%
  mutate(remote_ratio = case_when(
    remote_ratio == 0 ~ "Workplace",
    remote_ratio == 100 ~ "Remote",
    remote_ratio > 0 ~ "Hybrid",
    remote_ratio < 100 ~ "Hybrid"))


salaries2025 <- salaries2025 %>%
  mutate(employment_type = case_when(
    employment_type == "CT" ~ "Contract",
    employment_type == "FL" ~ "Freelance",
    employment_type == "FT" ~ "Full time",
    employment_type == "PT" ~ "Part time"
  ))

salaries2025 <- salaries2025 %>%
  filter(company_location == "US") %>%
  filter(employment_type == "Full time") %>%
  filter(work_year == "2023" | work_year == "2024"| work_year == "2025") %>%
  select(job_title, 
         salary_in_usd,
         experience_level,
         remote_ratio, 
         work_year) %>%
  mutate(ID = row_number())

head(salaries2025)


standardize_theme <- function(x) {
  theme_minimal(base_size = x) +
    theme(
      axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = x),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank(),
      plot.margin = margin(1, 1, 1, 1, "cm")
    )
}

h <- ggplot(salaries2025, aes(x = salary_in_usd))+
  geom_histogram(bins = 30, fill = "#80CCFF")+
  labs(title = "Istogramma della distribuzione \ndel salario annuale",
       x = "Salario annuale ($)",
       y = "Conteggio") +
  standardize_theme(12) +
  scale_y_continuous(labels = scales::comma_format(big.mark = ".")) +
  scale_x_continuous(labels = scales::comma_format(big.mark = "."),
                     breaks = seq(0, max(salaries2025$salary_in_usd, na.rm = TRUE), by = 100000))


box <- ggplot(salaries2025, aes(x = factor(1), y = salary_in_usd))+
  geom_violin(trim = FALSE, , fill = "#80CCFF", alpha = 0.5) +
  geom_boxplot(outlier.shape = NA, 
               fill = "#80ACFF",
               width = 0.2,  
               color = "black") +
  labs(title = "Boxplot del salario \nannuale",
       y = "Salario medio annulae ($)",
       x = "") +
  standardize_theme(12) +
  scale_y_continuous(labels = scales::comma_format(big.mark = "."),
                     breaks = seq(0, max(salaries2025$salary_in_usd, na.rm = TRUE), by = 100000))

grid.arrange(h, box, ncol = 2)

salaries2025_renamed <- salaries2025 %>%
  select(-work_year)

colnames(salaries2025_renamed) <- c("Job", "Mean_Salary", "Profile", "Remote", "ID")

salaries2025_cleaned <- clean_and_split_job(salaries2025_renamed)

salaries_complete <- left_join(salaries2025_renamed, salaries2025_cleaned, by = "ID")


# Normality Test
library(nortest)
normality_test <- ad.test(salaries2025$salary_in_usd)
print(normality_test)

# Dizionario che mappa ogni parola alla sua categoria
word_category_dict <- setNames(
  clustered_terms$Job_Category,
  tolower(clustered_terms$term)
)

#funzione che prende il valore e restituisce la categoria corrispondente
find_category3 <- function(job_clean, dict) {
  job_clean_lower <- tolower(job_clean)

  if (grepl("manager", job_clean_lower)){
    return("Unspecified Manager")
  }
  
  words <- unlist(strsplit(job_clean_lower, " "))
  matching_categories <- dict[words]
  
  category <- na.omit(matching_categories)[1]
  return(if(length(category) > 0) category else "Other")
}

# Applica la funzione find_category a job_title
salaries_complete$Job_Category <- vapply(
  salaries_complete$Job_Clean,
  find_category3,
  character(1),
  dict = word_category_dict
)

library(tidyverse)

salaries_complete <- salaries_complete %>%
  mutate(Job_Category = ifelse(is.na(Job_Category) | Job_Category == "", "Other", Job_Category)) %>%
  


table(salaries2025$Job_Category)

# Rinominare le colonne nel dataset 'salaries2025' per farle corrispondere a 'dati'

salaries2025_renamed <- salaries2025_renamed %>%
  mutate(Low_Salary = Mean_Salary*0.87,
         High_Salary = Mean_Salary*1.13)


salaries2025_renamed$ID <- as.character(salaries2025_renamed$ID)
dati$ID <- as.character(dati$ID)

View(salaries2025_renamed)

dati <- bind_rows(dati, salaries2025_renamed)
View(dati)



