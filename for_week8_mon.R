-----
  
  ### Beyond Linear Regression
  
  
  ::::: columns
::: column

**Neural Networks**
  
  * What people are talking about right now when they say *"AI models*.

* Linear regression on steroids:
    + Layers and layers of linear regression models.
    + After each layer, the model is transformed.
    + In simple linear regression we have two model parameters: $\beta_o$ and $\beta_1$.
    + In Gemini 3 Flash, there are between 1.2 and 1.8 trillion parameters.


:::


::: column

**Regression Trees**

* Useful if 
    + Have a lot of categorical variables (with many categories).
    + Expect local interaction effects.
* Also work for response variable is categorical.  Then called **Classification Trees**>


:::
:::::

---


------------------------------------------------------------------------

### Example

Let's look at a dataset of high school seniors in PA (`PASeniors`) and ask the question: 


XXX Can we build a model to predict whether or not a student will select "happy" as the answer to the question "When you grow up, would you prefer to be famous, happy, healthy, or rich?"

```{r}
#| output-location: column

library(Lock5Data)
data(PASeniors)
glimpse(PASeniors)

```


------------------------------------------------------------------------

### Regression Trees

-   Recursively split sample into two groups based on a predictor.
    -   Trying at each split to make the groups as homogeneous as possible (in terms of the response variable).
-   **Stop** splitting when it is no longer very predictively useful to do so.

::: columns
::: {.column width="15%"}
:::

::: {.column width="70%"}
```{r, echo = FALSE, fig.width = 12, fig.asp = 0.5}
library(rpart)
hw_tree <- rpart(HWHours ~ Sleep1 + GetToSchool + SchoolPressure + Preference + 
                      TextsSent + HangHours + Gender + Age + WorkHours,
                    data = PASeniors, method = "anova", 
                   control = rpart.control(cp = 0, minsplit = 2))

printcp(hw_tree)

library(rattle)
hw_tree_pruned <- prune(hw_tree, cp = 0.024)
fancyRpartPlot(hw_tree_pruned, cex  =  .8, caption = "", type = 2)
```
:::

::: {.column width="15%"}
:::
:::

------------------------------------------------------------------------

```{r, fig.width = 12, fig.asp = 0.5}
library(rpart)
happy_tree <- rpart(PreferenceH ~ Sleep1 + GetToSchool + TextsSent +
                      VideoGameHours + Gender, data = PASeniors)
library(rattle)
fancyRpartPlot(happy_tree, cex  =  .8, caption = "", type = 2)
```

------------------------------------------------------------------------

