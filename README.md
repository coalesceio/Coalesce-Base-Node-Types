# Coalesce Base Node Types Package

The Coalesce Base Node Types Package includes:

* [Work](#work)
* [Persistent Stage](#persistent-stage)
* [Dimension](#dimension)
* [Fact](#fact)
* [Factless Fact](#factless-fact)
* [View](#view)
* [Code](#code)

## Work

The Coalesce work node is a versatile node that allows you to develop and deploy a Work table/view in Snowflake.

A Work node serves as an intermediary object and is commonly employed to store raw data before undergoing the crucial phases of transformation and loading into the main tables of the data warehouse.

This pivotal step ensures that the raw data is processed and structured effectively.

### Work Node Configuration

The Work node type has two configuration groups:

* [Node Properties](#work-node-properties)
* [Options](#work-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

<h4 id="work-node-properties"> Work Node Properties </h4>

There are four configs within the **Node Properties** group.

* **Storage Location**: Storage Location where the WORK will be created.
* **Node Type**: Name of template used to create node objects.
* **Description**: A description of the node's purpose.
* **Deploy Enabled**:
  * If TRUE the node will be deployed / redeployed when changes are detected.
  * If FALSE the node will not be deployed or will be dropped during redeployment.
    
<h4 id="work-options">Work Options</h4>

Your available options will change depending on table or view.

**Create As Table**

![Work_options_table1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/f5643f40-fb37-4182-a11b-577bdc3e8f8d)

* **Multi Source**: True / False toggle that is Coalesce implementation of SQL UNIONs.
    * True - Multiple sources can be combined in a single node. The sources are combined using the option specified in the Multi Source Strategy.
	    * UNION - Combines with duplicate elimination.
		* UNION ALL - Combines without duplicate elimination.
		* INSERT - [Missing Content]
    * False - Single source node or multiple sources combined using a join.
* **Truncate Before**: True / False toggle that determines whether or not a table is overwritten each time a task executes.
    * True - INSERT OVERWRITE is used to overwrite existing data with new data loaded by task
    * False - INSERT is used to append new data into target table
* **Enable tests**:
* **Distinct**: True/False toggle that determines whether to add DISTINCT to SQL Query.
    * True - Group by All is invisible. DISTINCT data is chosen for processing
    * False- Group by All is visible
* **Group by All**: True/False toggle that determines whether to add GROUP BY ALL to SQL Query.
    * True - DISTINCT is invisible. Data is grouped by all columns for processing
    * False- DISTINCT is visible
* **Order By** : True/False toggle that determines whether to add “ORDER BY” to SQL Query along with the column and sort order
    * True -Sort column and sort order drop down are visible and are required to form order by clause
    * False-Sort column and sort order drop down are invisible
* **Pre-SQL**: Any SQL to be executed as a predecessor to data insert operation can be mentioned here
* **Post-SQL**: Any SQL to be executed post the data insert operation can be specified here

**Create As view**

![Work_options_view1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/7881c46e-0424-46ca-9a89-d111b5dbc379)

* **Override Create SQL**:True/False that determines whether a customized Create SQL is required to be executed.
    * True-Customized Create SQL specified in the Create SQL space is executed.All other options are invisible.
    * False-Create view SQL based on the options chosen are framed and executed.
* **Multi Source**: True / False toggle that is Coalesce implementation of SQL UNIONs.
    * True - Multiple sources can be combined in a single node. The sources are combined using the option specified in the Multi Source Strategy.
	    * UNION - Combines with duplicate elimination.
		* UNION ALL - Combines without duplicate elimination.
		* INSERT - [Missing Content]
    * False - Single source node or multiple sources combined using a join.
* **Distinct**: True/False toggle that determines whether to add DISTINCT to SQL Query.
    * True - Group by All is invisible. DISTINCT data is chosen for processing
    * False- Group by All is visible
* **Group by All**: True/False toggle that determines whether to add GROUP BY ALL to SQL Query.
    * True - DISTINCT is invisible. Data is grouped by all columns for processing
    * False- DISTINCT is visible


### Work Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

![work_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/2dc81bb8-2285-46e1-8b93-ce7082800fc5)

> 📘 Specify Group by and Order by Clauses
> 
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.


### Work Deployment

#### Work Initial Deployment
When deployed for the first time into an environment the Work node of materialization type table will execute the below stage:

**Create Work Table**
This will execute a CREATE OR REPLACE statement and create a table in the target environment.

When deployed for the first time into an environment the Work node of materialization type view will execute the below stage:

**Create Work View**
This will execute a CREATE OR REPLACE statement and create a view in the target environment.

#### Work Redeployment

After the WORK node with materialization type table has been deployed for the first time into a target environment, subsequent deployments may result in either altering the WORK Table or recreating the WORK table.

#### Altering the Work Tables

There are few column or table changes like Change in table name,Dropping existing column, Alter Column data type,Adding a new column if made in isolation or all-together will result in an ALTER statement to modify the Work Table in the target environment.

The following stages are executed:

* **Clone Table**: Creates an internal table.
* **Rename Table| Alter Column | Delete Column | Add Column| Edit table description |**: Alter table statement is executed to perform the alter operation.
* **Swap cloned Table**: Upon successful completion of all updates, the clone replaces the main table ensuring that no data is lost.
* **Delete Table**: Drops the internal table.

#### Recreating the Work tables

If any changes like change in join clause,adding transformations,change in configs like adding distinct,group by or orderby ,the Work Table will be recreated by running a CREATE OR REPLACE statement.

#### Recreating the Work views

The subsequent deployment of Work node of materialization type view with changes in view definition,adding table description or renaming view results in deleting the existing view and recreating the view

The following stages are executed:

* **Delete View**
* **Create View**

#### Work Undeployment

If a Work Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the WorkTable in the target environment will be dropped.

This is executed in two stages:

* **Delete Table**: Coalesce Internal table is dropped.
* **Delete Table**: Target table in Snowflake is dropped.

If a Work Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the WorkView in the target environment will be dropped.

The stage executed:

**Delete View**: Drops the existing Work view from target environment.

## Persistent Stage

The Coalesce Persistent Stage Nodes element, serving as an intermediary object, is frequently utilized to maintain data persistence across multiple execution cycles.

It plays a crucial role in tracking the historical changes of columns linked to business keys.

This functionality is particularly beneficial when the objective is to retain raw data for prolonged durations.

### Persistent Stage Node Configuration

The Persistent node type has two configuration groups:

* [Node Properties](#persistent-stage-node-properties)
* [Options](#persistent-stage-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

<h4 id="persistent-stage-node-properties"> Persistent Stage Node Properties </h4>

There are four configs within the **Node Properties** group.

* **Storage Location**: Storage Location where the WORK will be created.
* **Node Type**: Name of template used to create node objects.
* **Description**: A description of the node's purpose.
* **Deploy Enabled**:
  * If TRUE the node will be deployed / redeployed when changes are detected.
  * If FALSE the node will not be deployed or will be dropped during redeployment.

<h4 id="persistent-stage-options"> Persistent Stage Options </h4>

**Create As Table**

![pstage_options1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/3914feb3-1db7-452b-8590-7c657b99c0eb)

* **Create As**: Table is the only option at this time.
* **Multi Source**: True / False toggle that is Coalesce implementation of SQL UNIONs.
    * True - Multiple sources can be combined in a single node. The sources are combined using the option specified in the Multi Source Strategy.
		* UNION: Combines with duplicate elimination.
		* UNION ALL: Combines without duplicate elimination.
    * False - Single source node or multiple sources combined using a join.
* **Business key**: It is a required column for both Type 1 and Type 2.
* **Change tracking**: It is a required column for Type 2 .
* **Truncate Before**: True / False toggle that determines whether or not a table is overwritten each time a task executes.
    * True - INSERT OVERWRITE is used to overwrite existing data with new data loaded by task
    * False - INSERT is used to append new data into target table
* **Enable tests**: Provides option to specify tests in Testing section to check the data quality.
* **Distinct**: True/False toggle that determines whether to add DISTINCT to SQL Query.
    * True - Group by All is invisible. DISTINCT data is chosen for processing
    * False- Group by All is visible
* **Group by All**: True/False toggle that determines whether to add GROUP BY ALL to SQL Query.
    * True - DISTINCT is invisible. Data is grouped by all columns for processing
    * False- DISTINCT is visible
* **Order By** : True/False toggle that determines whether to add “ORDER BY” to SQL Query along with the column and sort order
    * True -Sort column and sort order drop down are visible and are required to form order by clause
    * False-Sort column and sort order drop down are invisible
* **Pre-SQL**: Any SQL to be executed as a predecessor to data insert operation can be mentioned here
* **Post-SQL**:Any SQL to be executed post the data insert operation can be specified here.




### Persistent Stage Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI

![pstage_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/84ce06c9-103c-4700-ad3d-2e8222995b31)

> 📘 Specify Group by and Order by Clauses
> 
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Persistent Stage Deployment

####  Persistent Stage Initial Deployment
When deployed for the first time into an environment the Persistent node will execute the below stage:

**Create Persistent Table**: This will execute a CREATE OR REPLACE statement and create a table in the target environment.

#### Persistent Stage Redeployment

After the Persistent node has been deployed for the first time into a target environment, subsequent deployments may result in either altering the Persistent Table or recreating the Persistent table.

#### Altering the Persistent tables

There are few column or table changes like Change in table name,Dropping existing column, Alter Column data type,Adding a new column if made in isolation or all-together will result in an ALTER statement to modify the Persistent Table in the target environment.

The following stages are executed:

* **Clone Table**: Creates an internal table
* **Rename Table| Alter Column | Delete Column | Add Column| Edit table description |**: Alter table statement is executed to perform the alter operation.
* **Swap cloned Table**: Upon successful completion of all updates, the clone replaces the main table ensuring that no data is lost.
* **Delete Table**: Drops the internal table

### Recreating the Persistent tables

If any changes like change in join clause,adding transformations,change in business key column,change in configs like adding distinct,group by or orderby ,the Persistent Table will be recreated by running a CREATE OR REPLACE statement.

### Persistent Stage Undeployment

If a Persistent Node is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Persistent Table in the target environment will be dropped.

This is executed in two stages:

* **Delete Table**
* **Drop Table or View**

## DIMENSION

The Coalesce Dimension UDN is a versatile node that allows you to develop and deploy a Dimension table in Snowflake.

A dimension table or dimension entity is a table or entity in a star, snowflake, or starflake schema that stores details about the facts.Dimension tables describe the different aspects of a business process

### Dimension Node Configuration

The Dimension node type has two configuration groups:

* [Node Properties](#dimension-node-properties)
* [Options](#dimension-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

<h4 id="dimension-node-properties"> Dimension Node  Properties </h4>

There are four configs within the **Node Properties** group.

* **Storage Location**: Storage Location where the WORK will be created.
* **Node Type**: Name of template used to create node objects.
* **Description**: A description of the node's purpose.
* **Deploy Enabled**:
  * If TRUE the node will be deployed / redeployed when changes are detected.
  * If FALSE the node will not be deployed or will be dropped during redeployment.

<h4 id="dimension-options">Dimension Options</h4>

**Create As Table**

![pstage_options1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/93b431e5-1d5a-45e9-8fe0-2fd6df2a499e)

* **Create As**: Table is the only option at this time.
* **Multi Source**: True / False toggle that is Coalesce implementation of SQL UNIONs.
    * True - Multiple sources can be combined in a single node. The sources are combined using the option specified in the Multi Source Strategy.
		* UNION: Combines with duplicate elimination.
		* UNION ALL: Combines without duplicate elimination.
    * False - Single source node or multiple sources combined using a join.
* **Business key**: It is a required column for both Type 1 and Type 2 Dimensions.
* **Change tracking**: It is a required column for Type 2 Dimension.
* **Truncate Before**: True / False toggle that determines whether or not a table is overwritten each time a task executes.
    * True - INSERT OVERWRITE is used to overwrite existing data with new data loaded by task
    * False - INSERT is used to append new data into target table
* **Enable tests**: Provides option to specify tests in Testing section to check the data quality.
* **Distinct**: True/False toggle that determines whether to add DISTINCT to SQL Query.
    * True - Group by All is invisible. DISTINCT data is chosen for processing
    * False- Group by All is visible
* **Group by All**: True/False toggle that determines whether to add GROUP BY ALL to SQL Query.
    * True - DISTINCT is invisible. Data is grouped by all columns for processing
    * False- DISTINCT is visible
* **Order By** : True/False toggle that determines whether to add “ORDER BY” to SQL Query along with the column and sort order
    * True -Sort column and sort order drop down are visible and are required to form order by clause
    * False-Sort column and sort order drop down are invisible
* **Pre-SQL**: Any SQL to be executed as a predecessor to data insert operation can be mentioned here
* **Post-SQL**:Any SQL to be executed post the data insert operation can be specified here


### Dimension Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI

![Dimension_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/5c3df3b0-f56d-4276-a51f-22364206b3c3)


> 📘 Specify Group by and Order by Clauses
> 
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Dimension Deployment

#### Dimension Initial Deployment
When deployed for the first time into an environment the Dimension node of materialization type table will execute theCreate Dimension Table stage.

**Create Dimension Table**: This will execute a CREATE OR REPLACE statement and create a table in the target environment.

When deployed for the first time into an environment the Dimension node of materialization type view will execute the Create Dimension View stage.

**Create Dimension View**: This will execute a CREATE OR REPLACE statement and create a view in the target environment.

#### Dimension Redeployment

After the Dimension node of materialization type table has been deployed for the first time into a target environment, subsequent deployments may result in either altering the Dimension Table or recreating the Dimension table

#### Altering the Dimension tables

There are few column or table changes like Change in table name,Dropping existing column, Alter Column data type,Adding a new column if made in isolation or all-together will result in an ALTER statement to modify the Dimension Table in the target environment.

The following stages are executed

* **Clone Table**: Creates an internal table.
* **Rename Table| Alter Column | Delete Column | Add Column| Edit table description |**: Alter table statement is executed to perform the alter operation.
* **Swap Cloned Table**: Upon successful completion of all updates, the clone replaces the main table
ensuring that no data is lost.
* **Delete Table**: Drops the internal table.

#### Recreating the Dimension Tables

If any changes like change in join clause,adding transformations,change in business key column,change in configs like adding distinct,group by or orderby ,the Dimension Table will be recreated by running a CREATE OR REPLACE statement.

#### Recreating the Dimension Views

The subsequent deployment of Dimension node of materialization type view with changes in view definition,adding table description or renaming view results in deleting the existing dimension view and recreating the dimension view

### Dimension Undeployment

If a Dimension Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Dimension Table in the target environment will be dropped.

This is executed in two stages:

* **Delete Table**: Coalesce Internal table is dropped.
* **Delete Table**: Target table in Snowflake is dropped.

If a Dimension Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Dimension View in the target environment will be dropped.

The stage executed:

* **Delete View**: Drops the existing Dimension view from target environment.

## FACT

The Coalesce Fact UDN is a versatile node that allows you to develop and deploy a Fact table in Snowflake.

A fact table or a fact entity is a table or entity in a star or snowflake schema that stores measures that measure the business, such as sales, cost of goods, or profit. Fact tables and entities aggregate measures , or the numerical data of a business.

### Fact Node Configuration

The Fact node type has two configuration groups:

* [Node Properties](#fact-node-properties) 
* [Options](#fact-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

<h4 id="fact-node-properties"> Fact Node Properties </h4>

There are four configs within the **Node Properties** group.

* **Storage Location**: Storage Location where the WORK will be created.
* **Node Type**: Name of template used to create node objects.
* **Description**: A description of the node's purpose.
* **Deploy Enabled**:
  * If TRUE the node will be deployed / redeployed when changes are detected.
  * If FALSE the node will not be deployed or will be dropped during redeployment.

<h4 id="fact-options"> Fact Options </h4>

Your available options will change depending on table or view.

**Create As Table**

![fact_options](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/fe15f4d1-fccc-4522-a75b-71682a8ef493)

* **Multi Source**: True / False toggle that is Coalesce implementation of SQL UNIONs.
    * True - Multiple sources can be combined in a single node. The sources are combined using the option specified in the Multi Source Strategy.
	    * UNION - Combines with duplicate elimination.
		* UNION ALL - Combines without duplicate elimination.
		* INSERT - [Missing Content]
    * False - Single source node or multiple sources combined using a join.
* **Business key**: It is a required column for Fact table creation.
* **Truncate Before**: True / False toggle that determines whether or not a table is overwritten each time a task executes.
    * True - INSERT OVERWRITE is used to overwrite existing data with new data loaded by task
    * False - INSERT is used to append new data into target table
* **Enable tests**:
* **Distinct**: True/False toggle that determines whether to add DISTINCT to SQL Query.
    * True - Group by All is invisible. DISTINCT data is chosen for processing
    * False- Group by All is visible
* **Group by All**: True/False toggle that determines whether to add GROUP BY ALL to SQL Query.
    * True - DISTINCT is invisible. Data is grouped by all columns for processing
    * False- DISTINCT is visible
* **Order By** : True/False toggle that determines whether to add “ORDER BY” to SQL Query along with the column and sort order
    * True -Sort column and sort order drop down are visible and are required to form order by clause
    * False-Sort column and sort order drop down are invisible
* **Pre-SQL**: Any SQL to be executed as a predecessor to data insert operation can be mentioned here
* **Post-SQL**: Any SQL to be executed post the data insert operation can be specified here

**Create As view**

![Work_options_view1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/7881c46e-0424-46ca-9a89-d111b5dbc379)

* **Override Create SQL**:True/False that determines whether a customized Create SQL is required to be executed.
    * True-Customized Create SQL specified in the Create SQL space is executed.All other options are invisible.
    * False-Create view SQL based on the options chosen are framed and executed.
* **Multi Source**: True / False toggle that is Coalesce implementation of SQL UNIONs.
    * True - Multiple sources can be combined in a single node. The sources are combined using the option specified in the Multi Source Strategy.
	    * UNION - Combines with duplicate elimination.
		* UNION ALL - Combines without duplicate elimination.
    * False - Single source node or multiple sources combined using a join.
* **Distinct**: True/False toggle that determines whether to add DISTINCT to SQL Query.
    * True - Group by All is invisible. DISTINCT data is chosen for processing
    * False- Group by All is visible
* **Group by All**: True/False toggle that determines whether to add GROUP BY ALL to SQL Query.
    * True - DISTINCT is invisible. Data is grouped by all columns for processing
    * False- DISTINCT is visible


### Fact Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the UI

![fact_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/e540d2d0-2623-4b99-a435-a26df5fe3306)

> 📘 Specify Group by and Order by Clauses
> 
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Fact Deployment

#### Fact Initial Deployment

When deployed for the first time into an environment the Fact node of materialization type table will execute the Create Fact Table stage.

**Create Fact Table**: This will execute a CREATE OR REPLACE statement and create a table in the target environment.

When deployed for the first time into an environment the Fact node of materialization type view will execute the Create Fact View stage.

**Create Fact View**: This will execute a CREATE OR REPLACE statement and create a view in the target environment.

#### Fact Redeployment

After the Fact node of materialization type table has been deployed for the first time into a target environment, subsequent deployments may result in either altering the Fact Table or recreating the Fact table.

#### Altering the Fact Tables

There are few column or table changes like Change in table name,Dropping existing column, Alter Column data type,Adding a new column if made in isolation or all-together will result in an ALTER statement to modify the Fact Table in the target environment.

The following stages are executed

* **Clone Table**

Creates an internal table

* **Rename Table| Alter Column | Delete Column | Add Column| Edit table description |**: Alter table statement is executed to perform the alter operation accordingly.
* **Swap Cloned Table**: Upon successful completion of all updates, the clone replaces the main table ensuring that no data is lost.
* **Delete Table**: Drops the internal table

#### Recreating the Fact Tables

If any changes like change in join clause,adding transformations,change in business key column,change in configs like adding distinct,group by or orderby ,the Fact Table will be recreated by running a CREATE OR REPLACE statement.

#### Recreating the Fact Views

The subsequent deployment of Fact node of materialization type view with changes in view definition,adding table description or renaming view results in deleting the existing view and recreating the view

The following stages are executed

* **Delete View**
* **Create View**

### Fact Undeployment

If a Fact Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Fact Table in the target environment will be dropped.

This is executed in two stages:

1. **Delete Table**: Coalesce Internal table is dropped.
2. **Delete Table**: Target table in Snowflake is dropped

If a Fact Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Fact View in the target environment will be dropped.

The stage executed:

* **Delete View**: Drops the existing Fact view from target environment.

## FACTLESS FACT

The Coalesce Fact UDN is a versatile node that allows you to develop and deploy a Fact table in Snowflake.

A factless fact table is used to record events or situations that have no measures, and it has the same level of detail as the dimensions

#### Factless Fact Node Configuration

The Fact node type has two configuration groups:

* [Node Properties](#node-properties)
* [Options](#factless-fact-options)

#### Factless Fact Options

**Create As Table**

![Factless_options](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/bf2430c4-2a62-4195-a817-e702461b2d14)


* **Create As**: Table is the only option at this time.
* **Multi Source**: True / False toggle that is Coalesce implementation of SQL UNIONs.
    * True - Multiple sources can be combined in a single node. The sources are combined using the option specified in the Multi Source Strategy.
	    * **UNION** - Combines with duplicate elimination.
		* **UNION ALL** - Combines without duplicate elimination.
    * False - Single source node or multiple sources combined using a join.
* **Truncate Before**: True / False toggle that determines whether or not a table is overwritten each time a task executes.
    * True - INSERT OVERWRITE is used to overwrite existing data with new data loaded by task.
    * False - INSERT is used to append new data into target table.
* **Enable tests**: Provides option to specify tests in Testing section to check the data quality.
* **Distinct**: True/False toggle that determines whether to add DISTINCT to SQL Query.
    * True - Group by All is invisible. DISTINCT data is chosen for processing.
    * False- Group by All is visible.
* **Group by All**: True/False toggle that determines whether to add GROUP BY ALL to SQL Query.
    * True - DISTINCT is invisible. Data is grouped by all columns for processing.
    * False- DISTINCT is visible.
* **Order By** : True/False toggle that determines whether to add “ORDER BY” to SQL Query along with the column and sort order.
    * True -Sort column and sort order drop down are visible and are required to form order by clause.
    * False-Sort column and sort order drop down are invisible
* **Pre-SQL**: Any SQL to be executed as a predecessor to data insert operation can be mentioned here.
* **Post-SQL**:Any SQL to be executed post the data insert operation can be specified here.


### Factless Fact Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the UI.

![fact_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/fc432c42-0315-4fb5-8f93-7836190086ff)

> 📘 Specify Group by and Order by Clauses
> 
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Factless Fact Deployment

#### Factless Fact Initial Deployment
When deployed for the first time into an environment the Factless Fact node of materialization type table will execute the Create Fact Table stage.

**Create Fact Table**: This will execute a CREATE OR REPLACE statement and create a table in the target environment.

#### Factless Fact Redeployment

After the Fact node of materialization type table has been deployed for the first time into a target environment, subsequent deployments may result in either altering the Fact Table or recreating the Fact table.

#### Altering the Factless Fact tables

There are few column or table changes like Change in table name,Dropping existing column, Alter Column data type,Adding a new column if made in isolation or all-together will result in an ALTER statement to modify the Factless fact Table in the target environment.

The following stages are executed:

* **Clone Table**: Creates an internal table.
* **Rename Table| Alter Column | Delete Column | Add Column| Edit table description |**: Alter table statement is executed to perform the alter operation.
* **Swap Cloned Table**: Upon successful completion of all updates, the clone replaces the main table ensuring that no data is lost.
* **Delete Table**: Drops the internal table.

#### Recreating the Factless Fact Tables

If any changes like change in join clause,adding transformations,change in business key column,change in configs like adding distinct,group by or orderby ,the Fact Table will be recreated by running a CREATE OR REPLACE statement.

### Factless Fact Undeployment

If a Fact Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Fact Table in the target environment will be dropped.

This is executed in two stages:

1. **Delete Table**: Coalesce Internal table is dropped.
2. **Delete Table**: Target table in Snowflake is dropped.
  
## VIEW
 
The Coalesce View UDN is a versatile node that allows you to develop and deploy a View in Snowflake.

A view allows the result of a query to be accessed as if it were a table. 
Views serve a variety of purposes, including combining, segregating, and protecting data.

### View Node Configuration

The View node type has two configuration groups:

* [Node Properties](#view-node-properties)
* [Options](#view-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

<h4 id="view-node-properties">View Node Properties </h4>

There are four configs within the **Node Properties** group.

* **Storage Location**: Storage Location where the WORK will be created.
* **Node Type**: Name of template used to create node objects.
* **Description**: A description of the node's purpose.
* **Deploy Enabled**:
  * If TRUE the node will be deployed / redeployed when changes are detected.
  * If FALSE the node will not be deployed or will be dropped during redeployment.

<h4 id="view-options">View Options</h4>

There are many configs within the **Options** group.

* **Override Create SQL**:True/False that determines whether a customized Create SQL is required to be executed.
    * True: Customized Create SQL specified in the Create SQL space is executed.All other options are invisible.
	    * UNION - Combines with duplicate elimination.
		* UNION ALL - Combines without duplicate elimination.
    * False: Create view SQL based on the options chosen are framed and executed.
* **Multi Source**: True / False toggle that is Coalesce implementation of SQL UNIONs.
    * True - Multiple sources can be combined in a single node. The sources are combined using the option specified in the Multi Source Strategy.
    * False - Single source node or multiple sources combined using a join.
* **Distinct**: True/False toggle that determines whether to add DISTINCT to SQL Query.
    * True - Group by All is invisible. DISTINCT data is chosen for processing
    * False- Group by All is visible
* **Group by All**: True/False toggle that determines whether to add GROUP BY ALL to SQL Query.
    * True - DISTINCT is invisible. Data is grouped by all columns for processing
    * False- DISTINCT is visible
* **Secure**:True/False toggle that determines whether to create secure view or not
    * True-A secured view is created
    * False-A normal view is created

### View Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the Coalesce app.

> 📘 Specify Group by Clauses
> 
> Best practice is to specify group by clauses in this space if you are not opting for the group by all provided in OPTIONS config.

### View Deployment

#### View Initial Deployment
When deployed for the first time into an environment the View node will execute the Create View stage.

**Create View**: This stage will execute a CREATE OR REPLACE statement and create a View in the target environment.

#### View Redeployment

The subsequent deployment of View node with changes in view definition,adding table description,adding secure option or renaming view results in deleting the existing view and recreating the view

####  Recreating the View

The following stages are executed:

* **Delete View**
* **Create View**

#### View Undeployment

If a View Node is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the View in the target environment will be dropped.

This is executed in the below stage:

* **Delete View**

## Code

### Work

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Work-204/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Work-204/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Work-204/run.sql.j2)

### Persistent Stage

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/PersistentStage-173/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/PersistentStage-173/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/PersistentStage-173/run.sql.j2)

### Dimension

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Dimension-194/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Dimension-194/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Dimension-194/run.sql.j2)

### Fact

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Fact-205/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Fact-205/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Fact-205/run.sql.j2)

### Factless Fact

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Factlessfact-248/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Factlessfact-248/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Factlessfact-248/run.sql.j2)

### View

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/View-188/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/View-188/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/View-188/run.sql.j2)

[Macros](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/macros/macro-1.yml)

[<img src="https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/608d9966-531a-41fe-af0d-ecf742721cba" alt="Git Logo" height="40">](https://github.com/coalesceio/Coalesce-Base-Node-Types)
