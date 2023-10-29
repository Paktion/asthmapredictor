
# Breath Easy

Breathe Easy is an iOS app that estimates a users relative peakflow based on a multitude of environmental and health related variables 


## Research Articles

 - [What is Asthma?](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6157154/)
 - [Feasability of Smartwatch to manage Asthma Symptoms](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5580199/)
 - [Significance of Biosignals and Environmental Factors for Predicting Asthma ](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8656014/#:~:text=There%20are%20two%20categories%20of,and%20clinical%20data%20%5B4%5D)
 - [How the Data was the Collected](https://bmjopen.bmj.com/content/12/10/e064166)
 - [Raw Data Files (saved in repository under AsthmaFiles)](https://datashare.ed.ac.uk/handle/10283/4761)



## Demo

Insert gif or link to demo


## Local Model Deployment

To deploy local flask application to call model

```bash
  flask --app flaskapis run
```
[Example URL to test model](http://127.0.0.1:5000/22.0/2.54/0.77/4.84/1040.0/98.0/0.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0)

## Moving Forward

- Hosting model on AWS Sagemaker
- Improve Model through addition of paramters
- Create User test to provide feedback for model
- Create WatchOS app
- Connect to weather API's

