## PrideParades

Exploratory analysis of 7 years of Pride parade line ups from a large liberal city in the northeast United States. 

### Data:
Original data consisted of pdf files with entity names, section, and meeting location. I manually transferred the entry names to an excel file and then manually labeled a number of features for each entity based on internet research and personal experience. Labeled fields are as follows:

* **Year:** Year of parade (YYYY)
* **Category:** String label for entity category (e.g. Community Organization, Arts and Entertainment, Company, etc)
* **Sector:** String label for sector of Company entities (e.g. Healthcare, Food/Drink, Retail, etc)
* **FunScore:** Integer from 1-10 for how "fun" the entry is. Loosely tied to Category, scale explanation can be found here: https://www.gaytascience.com/pride-less-fun/ 
* **L:** Binary variable indicating if entry is focused on/ inclusive of the Lesbian community. Groups with a broad "LGBT" mission have all 4 categories checked.
* **G:** Binary variable indicating if entry is focused on/ inclusive of the Gay community. Groups with a broad "LGBT" mission have all 4 categories checked.
* **B:** Binary variable indicating if entry is focused on/ inclusive of the Bisexual community. Groups with a broad "LGBT" mission have all 4 categories checked.
* **T:** Binary variable indicating if entry is focused on/ inclusive of the Transgender community. Groups with a broad "LGBT" mission have all 4 categories checked. 
* **Other:** Binary variable indicating if entry is focused on one of the letters in the "+" of LGBT+ (e.g. Queer, Ace, Pan)
* **None:** Binary variable indicating if entry has no apparent operational affiliation with the LGBTQ+ community
* **Eth_Culture_Race_Grp:** Binary variable indicating if entry is focused on / specific to a ethnicity, culture, or race.

I don't feel comfortable making public the raw files, my labeled dataset containing the entity names, or the city the records are from, in case the data was not supposed to be shared with me. 

### Notebooks:
Contains exploratory analysis and graphic generation code used in the posts below. 
* **Pride is Less Fun:** https://www.gaytascience.com/pride-less-fun/
