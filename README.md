# 🌍 StatsCanada Insights: Exploring Health, Environment, and Social Trends in Canada 📊

**Visualizing Canada’s Well-being with R and ggplot2**

Welcome to **StatsCanada Insights**, a major data visualization project developed as part of my Business Analytics studies. This project focuses on three critical areas of Canadian life—**Health**, **Environment**, and **Social Connectedness**—using official datasets from **Statistics Canada**. With R and ggplot2, I’ve transformed raw data into meaningful visual narratives, culminating in an engaging infographic that summarizes key findings.

---

## 📌 About Me

I’m **Abhishek Kumar Yadav**, a Business Analytics graduate from Humber College, passionate about uncovering insights from complex datasets. This project showcases my hands-on skills in **data cleaning**, **exploratory analysis**, and **data storytelling** using R.

---

## 📑 Table of Contents

- [Project Overview](#project-overview)
- [Project Structure](#project-structure)
- [How to Run](#how-to-run)
- [Visualizations and Insights](#visualizations-and-insights)
  - [Health Domain 🩺](#1-health-domain-)
  - [Environment Domain 🌱](#2-environment-domain-)
  - [Social Connectedness Domain 🤝](#3-social-connectedness-domain-)
- [Data Sources](#data-sources)
- [Acknowledgments](#acknowledgments)
- [Contact](#contact)

---

## 📊 Project Overview

This project analyzes and visualizes Statistics Canada data in three thematic domains:

### 🩺 Health
- Life expectancy across provinces
- Mental health status trends
- Adherence to 24-hour movement guidelines

### 🌱 Environment
- Air quality index vs. Canadian standards
- National GHG emissions over time
- Water usage patterns in cubic meters

### 🤝 Social Connectedness
- Sense of belonging to local communities
- Availability of personal support networks
- Gender and province-wise comparisons

**Tools Used**: R, ggplot2, dplyr, tidyverse, patchwork, readr  
**Data Source**: Statistics Canada & Canadian Community Health Survey

---

## 📁 Project Structure
StatsCanadaAnalysis/
├── data/                         # Raw datasets from Statistics Canada
├── scripts/                      # R scripts for analysis & visualization
├── output/                       # Final plots and infographic
├── README.md                     # This file
├── .gitignore                    # Ignored files
└── StatsCanadaAnalysis.Rproj     # RStudio project file


---

## 🎨 Visualizations and Insights

### 1. Health Domain 🩺

**Key Discoveries**:
- 🧬 Quebec shows the highest life expectancy (71.6 years); Newfoundland the lowest (66.3).
- 🧠 Mental health reports are concerning: 20.7% of Canadians reported poor mental health in 2023.
- 🏃‍♂️ Physical activity guideline adherence dropped between 2016–2021.

📂 **Scripts**:
- [`health.R`](scripts/health.R): Life expectancy and mental health by province
- [`health 24 hours.R`](scripts/health%2024%20hours.R): Physical activity adherence over time

🖼️ **Output**:
- ![Health Output](output/unified_health_analysis.png)

---

### 2. Environment Domain 🌱

**Key Discoveries**:
- 🌫️ Air quality improved from 63% in 2005 to 85% in 2019, but dropped post-COVID (2020).
- 🌍 GHG emissions peaked in 2007 and have since slowly declined.
- 💧 Water use is relatively stable but varies significantly across regions.

📂 **Scripts**:
- [`environment.R`](scripts/environment.R): Combines AQI and GHG emissions
- [`water usage.R`](scripts/water%20usage.R): Water consumption by sector over years

🖼️ **Output**:
<p align="center">
  <img src="output/infographic.png" alt="Environment Infographic" width="600"/><br>
  <em>Environment + Water Usage Infographic</em>
</p>

---

### 3. Social Connectedness Domain 🤝

**Key Discoveries**:
- 🏘️ Alberta has the highest community belonging score (66.9%); Newfoundland the lowest (51.9%).
- 🙋‍♀️ British Columbia leads in emotional support, with 68.6% saying they have someone to count on.
- 👥 Gender differences are also notable in perceived belonging and trust.

📂 **Scripts**:
- [`social.R`](scripts/social.R): Belonging to Canada by gender/year
- [`sense of belonging.R`](scripts/sense%20of%20belonging.R): Dot plot of community belonging vs. support

🖼️ **Output**:
- ![Social Connectedness Plot](output/Social_Connectedness_Dot_Plot.png)

---

## 📌 Key Takeaways & Recommendations

### 🩺 Health
- **Policy Recommendation**: Invest in mental health initiatives, especially in provinces like Newfoundland where life expectancy and reported well-being are low.
- **Actionable Insight**: Promote physical activity through targeted regional programs, especially for age groups showing decline.

### 🌱 Environment
- **Policy Recommendation**: Continue investing in clean energy to reduce GHG emissions.
- **Actionable Insight**: Monitor post-pandemic air quality dips and explore why CAAQS compliance fell.

### 🤝 Social Connectedness
- **Policy Recommendation**: Community belonging and emotional support must be addressed in Atlantic provinces.
- **Actionable Insight**: Gender-based emotional health initiatives could close the gap in perceived support systems.

---

## 📚 Data Sources

All datasets are publicly available from **Statistics Canada**:

### 🩺 Health
- [Life Expectancy (1310037001)](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310037001)
- [Mental Health (4510008001)](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=4510008001)
- [24-Hour Guidelines (1310082101)](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310082101)

### 🌱 Environment
- [Air Quality Index (CAAQS)](https://www.canada.ca/en/environment-climate-change/services/environmental-indicators/air-quality-health-index.html)
- [GHG Emissions](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3810024901)
- [Water Usage (3810025001)](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3810025001)

### 🤝 Social Connectedness
- [Sense of Belonging (4510005201)](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=4510005201)
- [Someone to Count On (4510005001)](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=4510005001)
- [Belonging to Canada (4510007701)](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=4510007701)

---

## 🙏 Acknowledgments  
- Datasets provided by **Statistics Canada** and the **Canadian Community Health Survey**  
- Visualizations built using `ggplot2`, `patchwork`, and `readr` in RStudio

---

## 📬 Contact

**Abhishek Kumar Yadav**  
📧 abhishekyadav23122002@gmail.com  
📞 +1 226-201-0011  
🔗 [LinkedIn](https://www.linkedin.com/in/abhishekyadavab) | [GitHub](https://github.com/abhishekyadavab)

---

> *“Turning public data into public insight — one chart at a time.”*

