# ENIAC-GOES-BRAZIL
<div align="center">
### Strategic Brazilian E-Commerce Partnership Assessment

![SQL](https://img.shields.io/badge/Data_Analysis-SQL-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Tableau](https://img.shields.io/badge/Visualization-Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)
![Canva](https://img.shields.io/badge/Design-Canva-00C4CC?style=for-the-badge&logo=canva&logoColor=white)
![Status](https://img.shields.io/badge/Recommendation-3--Year_Pilot-success?style=for-the-badge)

[▶ View the final presentation](Eniac-Supplier Fit Assessment_Magist.pdf)



</div>

---

## 🧭 Navigation
* [📌 About the Project](#-about-the-project)
* [🎯 Business Question](#-business-question)
* [📈 Key Numbers](#-key-numbers)
* [🧭 Methodology](#-methodology)
* [🔎 Key Findings](#-key-findings)
* [🏁 Recommendation](#-recommendation)
* [🧰 Tech Stack](#-tech-stack)
* [💾 Data Architecture](#-data-architecture)
* [📁 Repository Structure](#-repository-structure)
* [👥 Team](#-team)

---

## 📌 About the Project

This project is a business case about **Eniac**, a European technology company that wants to expand into the Brazilian market. 

Eniac is evaluating a three-year partnership with **Magist**, a Brazilian e-commerce service provider. Our task: analyze Magist's e-commerce data and decide whether Magist is a suitable partner, with a clear focus on selling and distributing technology products in Brazil.

> **Note:** This is a learning project built during the Data Science program at WBS Coding School. The dataset is fictional.

---

## 🎯 Business Question

Should Eniac sign a three-year partnership with Magist?

We answer it from four business perspectives:

| # | Perspective | Key questions |
| :---: | :---| :---|
| 1️⃣ | 📦 **Product Portfolio** | Which categories generate the most revenue? Which tech categories perform best? |
| 2️⃣ | 🚚 **Sellers & Delivery** | How long do sellers take to deliver? Which sellers have enough volume to be reliable? |
| 3️⃣ | 🌎 **Geographic Reach** | Which states and cities generate the most orders and revenue? |
| 4️⃣ | ⭐ **Reliability & Satisfaction** | How many orders arrive on time? Do late deliveries hurt customer reviews? |

---

## 📈 Key Numbers

| Metric | ENIAC | MAGIST |
| :--- | :---: | :---: |
| 💶 **Annual revenue** | 14 M € | 6.9 M € |
| 🏷️ **Average product price** | 540 € | 124 € |
| 🛍️ **Price range of tech products** | – | 57 € – 1,100 € |

### 🚚 Delivery Benchmarks
* **Magist (Brazil - National):** 12.5 days
* **Brazil Average (Black Friday 2025):** 8 days
* **Gap:** +4.5 days slower
* **EU Standard (Cross-border):** 3 – 7 days

> **Important:** Magist sells everything from small parts to expensive PCs. That is why its average price (124 €) is far below Eniac's (540 €), even though the tech range reaches up to 1,100 €.

---

## 🧭 Methodology

* **📦 Product performance:** We identify the categories with the highest revenue and evaluate how technology-related products perform.
* **🚚 Seller & delivery performance:** We analyze seller delivery times and compare sellers with a significant number of tech-related orders.
  > 💡 **Threshold:** Only sellers with at least 100 relevant orders are compared, to ensure a meaningful basis.
* **🌎 Geographic performance:** We analyze orders and revenue by Brazilian state and city to identify Magist's strongest markets.
* **⭐ Customer satisfaction:** We compare reviews for orders delivered on time versus delivered late to see whether delivery performance affects customer reviews.

---

## 🔎 Key Findings

### 🗺 Where does Magist earn its money?
The strongest revenue comes from the southeast and the east coast of Brazil, led by **São Paulo** and **Rio de Janeiro**.

| Top | City | Top | City |
| :---: | :--- | :---: | :--- |
| **1** | São Paulo (SP) | **6** | Porto Alegre (RS) |
| **2** | Rio de Janeiro (RJ) | **7** | Campinas (SP) |
| **3** | Belo Horizonte (MG) | **8** | Salvador (BA) |
| **4** | Brasília (DF) | **9** | Guarulhos (SP) |
| **5** | Curitiba (PR) | **10** | Niterói (RJ) |

---

## 🚚 Delivery is the biggest operational risk

```text
Magist        ████████████████████████  12.5 days
Brazil (avg)  ███████████████            8 days
EU standard   ██████ – ██████████████    3 – 7 days

Magist delivers on average 4.5 days slower than the Brazilian average, even though Brazilian logistics is considered dynamic and advanced overall.
Late deliveries on top of a long delivery time make this the most important risk point of the analysis.
⚠️ Warning: The Brazilian average of 8 days refers to the Black Friday 2025 period, a peak-load phase. Compare with care.
🏁 Recommendation

## DECISION: PROCEED WITH A 3-YEAR PILOT PARTNERSHIP (CONDITIONAL)

## 🏁 Recommendation

<div align="center">

### **DECISION: PROCEED WITH A 3-YEAR PILOT PARTNERSHIP (CONDITIONAL)**

</div>

The final recommendation on the three-year partnership is based on the combined findings across portfolio, sellers, geography and delivery:
* **Proceed with a 3-year pilot partnership** under strict operational control.
* **Set mandatory SLAs:** Guaranteed delivery windows (3–7 days) and minimum customer ratings (> 4 stars).
* **Smart entry:** Start with more affordable product lines before scaling high-end tech.

---

## 🧰 Tech Stack

| Tool | Purpose |
| :--- | :--- |
| **SQL** | Data analysis and business questions |
| **Tableau** | Data visualization |
| **Canva** | Final presentation |
| **GitHub** | Documentation and version control |

---

## 💾 Data Architecture

The project uses a fictional dataset based on Magist's e-commerce database:

| Core Entities | |
| :--- | :--- |
| 🛍️ Products | 🏷️ Categories |
| 🧑‍💼 Sellers | 👥 Customers |
| 🧾 Orders | 📋 Order items |
| 💳 Payments | ⭐ Reviews |
| 🌎 Geographical data | |

---

## 📁 Repository Structure

```text
📦 eniac-magist
 ┣ 📄 [README.md](README.md)             → Project overview, questions, findings
 ┣ 📄 [script.sql](script.sql)            → SQL queries used for the analysis
 ┣ 📊 [visualizations.twbx](visualizations.twbx)   → Tableau visualizations
 ┗ 📑 [presentation.pdf](presentation.pdf)      → Final presentation (PDF export)

