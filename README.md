<!-- markdownlint-disable MD033 -->
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

The Coalesce Work node is a versatile node that allows you to develop and deploy a Work table/view in Snowflake.

A Work node serves as an intermediary object and is commonly employed to store raw data before undergoing the crucial phases of transformation and loading into the main tables of the data warehouse.

This pivotal step ensures that the raw data is processed and structured effectively.

### Work Node Configuration

The Work node type has two configuration groups:

* [Node Properties](#work-node-properties)
* [Options](#work-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

### Work Node Properties

| Property | Description |
|----------|-------------|
| **Storage Location** | Storage Location where the WORK will be created |
| **Node Type**| Name of template used to create node objects |
| **Description** | A description of the node's purpose |
| **Deploy Enabled** | If **TRUE**: node will be deployed/redeployed when changes are detected<br/>If **FALSE**: node will not be deployed or will be dropped during redeployment |

### Work Options

#### Work Node Create as Table

![Work_options_table1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/f5643f40-fb37-4182-a11b-577bdc3e8f8d)

| Setting | Description |
|---------|-------------|
| **Multi Source** | Toggle: True/False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>- **INSERT**: Individual insert for each source<br/>**False**: Single source node or multiple sources combined using a join. |
| **Truncate Before** | Toggle: True/False<br/>This determines whether a table will be overwritten each time a task executes. **True**: Uses INSERT OVERWRITE<br/>**False**: Uses INSERT to append data |
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True/False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing.<br/>**False**: Group by All is visible. |
| **Group by All** | Toggle: True/False<br/>**True**: DISTINCT is invisible, data grouped by all columns<br/>**False**: DISTINCT is visible |
| **Order By** | Toggle: True/False<br/>**True**: Sort column and sort order drop down are visible and are required to form order by clause. <br/>**False**: Sort options invisible |
| **Pre-SQL**| SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

#### Work Node Create as View Options

![Work_options_view1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/7881c46e-0424-46ca-9a89-d111b5dbc379)

| Setting | Description |
|---------|-------------|
| **Override Create SQL** | Toggle: True/False<br/>**True**: Executes custom Create SQL<br/>**False**: Creates view based on chosen options |
| **Multi Source** | Toggle: True/False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single node.<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>- **INSERT**: Individual insert for each source<br/>**False**: Single source node or multiple sources combined using a join. |
| **Distinct** | Toggle: True/False<br/>**True**: Group by All invisible<br/>**False**: Group by All visible |
| **Group by All** | Toggle: True/False<br/>**True**: DISTINCT invisible. Data is grouped by all columns for processing.<br/>**False**: DISTINCT visible |

### Work Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

![work_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/2dc81bb8-2285-46e1-8b93-ce7082800fc5)

> 📘 Specify Group by and Order by Clauses
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Work Deployment

#### Work Initial Deployment

The following stages will execute when deployed for the first time.

1. **Create Work Table or Work View**: Executes CREATE OR REPLACE statement and create a table or view in the target environment.

#### Work Redeployment

After the WORK node with materialization type table has been deployed for the first time into a target environment, subsequent deployments may result in either altering the WORK Table or recreating the WORK table.

##### Altering Work Tables

A few types of column or table changes - such as changing table names, dropping existing columns, altering column data types, or adding new columns - will result in an ALTER statement to modify the Work Table in the target environment, whether these changes are made individually or all together.

1. **Clone Table**: Creates an internal table.
2. **Alter Operations**: Alter table statement is executed to perform the alter operation.
3. **Swap cloned Table**: Upon successful completion of all updates, the clone replaces the main table ensuring that no data is lost.
4. **Delete Table**: Drops the internal table.

##### Recreating Work Tables

Tables are recreated with CREATE OR REPLACE when changes include:

* Join clause changes
* Adding transformations
* Configuration changes (distinct, group by, order by)

##### Recreating Work Views

Views are recreated when changes include:

* View definition changes
* Description changes
* View renaming

The following stages are executed:

1. **Delete View**
2. **Create View**

#### Work Undeployment

If you delete a Work Node with type `table` or `view` from your Workspace, save those changes to Git, and then deploy them to another environment - the table will also be deleted in that environment. The following stages are executed.

For tables:

1. **Delete Internal Table**: Drops Coalesce internal table
2. **Delete Target Table**: Drops Snowflake target table

For views:

1. **Delete View**: Drops existing Work view

## Persistent Stage

The Coalesce Persistent Stage Nodes element serves as an intermediary object, frequently utilized to maintain data persistence across multiple execution cycles.

It plays a crucial role in tracking the historical changes of columns linked to business keys, particularly beneficial when retaining raw data for prolonged durations.

### Persistent Stage Node Configuration

The Persistent node type has two configuration groups:

* [Node Properties](#persistent-stage-node-properties)
* [Options](#persistent-stage-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

### Persistent Stage Node Properties

| Property | Description |
|----------|-------------|
| **Storage Location** | Storage Location where the stage will be created |
| **Node Type** | Name of template used to create node objects |
| **Description** | A description of the node's purpose |
| **Deploy Enabled** | If **TRUE**: node will be deployed/redeployed when changes are detected<br/>If **FALSE**: node will not be deployed or will be dropped during redeployment |

### Persistent Stage Options

![pstage_options1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/3914feb3-1db7-452b-8590-7c657b99c0eb)

| Setting | Description |
|---------|-------------|
| **Create As**| Table is currently the only option |
| **Multi Source** | Toggle: True/False<br/>**True**: Multiple sources with UNION/UNION ALL<br/>**False**: Single source or joined sources |
| **Business key** | Required column for both Type 1 and Type 2 |
| **Change tracking** | Required column for Type 2 |
| **Truncate Before** | Toggle: True/False<br/>**True**: Uses INSERT OVERWRITE<br/>**False**: Uses INSERT to append |
| **Enable tests** | Option to specify data quality tests |
| **Distinct** | Toggle: True/False<br/>**True**: Group by All invisible<br/>**False**: Group by All visible |
| **Group by All** | Toggle: True/False<br/>**True**: DISTINCT invisible<br/>**False**: DISTINCT visible |
| **Order By** | Toggle: True/False<br/>**True**: Sort options visible<br/>**False**: Sort options invisible |
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

### Persistent Stage Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

![pstage_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/84ce06c9-103c-4700-ad3d-2e8222995b31)

> 📘 Specify Group by and Order by Clauses
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Persistent Stage Deployment

#### Persistent Stage Initial Deployment

The following stages will execute when deployed for the first time.

1. **Create Persistent Table**: Executes CREATE OR REPLACE statement

#### Persistent Stage Redeployment

After a Persistent table is first created in an environment, any later updates might either alter the existing table or delete and recreate it.

##### Altering Persistent Tables

A few types of column or table changes will result in an ALTER statement to modify the Persistent Table in the target environment, whether these changes are made individually or all together:

1. Changing table names
2. Dropping existing columns
3. Altering column data types
4. Adding new columns

For column/table changes the following stages are executed

1. **Clone Table**: Creates internal table
2. **Alter Operations**: Executes necessary ALTER statements
3. **Swap Cloned Table**: Replaces main table with clone
4. **Delete Table**: Drops internal table

##### Recreating Persistent Tables

Tables are recreated with CREATE OR REPLACE when changes include:

* Join clause changes
* Adding transformations
* Business key changes
* Configuration changes

#### Persistent Stage Undeployment

If a node is deleted from a Workspace, commited to Git and then that commit is deployed, then the Persistent Table in the target environment is dropped. The following stages are executed.

1. **Delete Table**
2. **Drop Table or View**

## Dimension

The Coalesce Dimension UDN allows you to develop and deploy a Dimension table in Snowflake.

A dimension table stores details about facts in a star, snowflake, or starflake schema. Dimension tables describe different aspects of a business process.

### Dimension Node Configuration

The Dimension node type has two configuration groups:

* [Node Properties](#dimension-node-properties)
* [Options](#dimension-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

### Dimension Node Properties

| Property | Description |
|----------|-------------|
| **Storage Location** | Storage Location where the dimension will be created |
| **Node Type** | Name of template used to create node objects |
| **Description** | A description of the node's purpose |
| **Deploy Enabled** | If **TRUE**: node will be deployed/redeployed when changes are detected<br/>If **FALSE**: node will not be deployed or will be dropped during redeployment |

### Dimension Options

![pstage_options1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/93b431e5-1d5a-45e9-8fe0-2fd6df2a499e)

| Setting | Description |
|---------|-------------|
| **Create As** | Table is currently the only option |
| **Multi Source** | Toggle: True/False<br/>**True**: Multiple sources can be combined in a single node. <br/> - **UNION**: Combines with duplicate elimination. <br/> - **UNION ALL**: Combines without duplicate elimination. <br/> **False**: Single source or joined sources |
| **Business key** | Required column for Type 1 and Type 2 Dimensions |
| **Change tracking** | Required column for Type 2 Dimension |
| **Truncate Before** | Toggle: True/False<br/>**True**: Uses INSERT OVERWRITE<br/>**False**: Uses INSERT to append |
| **Enable tests** | Option to specify data quality tests |
| **Distinct** | Toggle: True/False<br/>**True**: Group by All invisible<br/>**False**: Group by All visible |
| **Group by All** | Toggle: True/False<br/>**True**: DISTINCT invisible<br/>**False**: DISTINCT visible |
| **Order By**| Toggle: True/False<br/>**True**: Sort column and sort order drop down are visible and are required to form order by clause<br/>**False**: Sort options invisible |
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

### Dimension Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

![Dimension_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/5c3df3b0-f56d-4276-a51f-22364206b3c3)

> 📘 Specify Group by and Order by Clauses
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Dimension Deployment

#### Dimension Initial Deployment

For tables:

1. **Create Dimension Table**: Executes CREATE OR REPLACE statement

For views:

1. **Create Dimension View**: Executes CREATE OR REPLACE statement

#### Dimension Redeployment

Subsequent deployments may result in either altering the Dimension Table or recreating the Dimension table.

##### Altering Dimension Tables

A few types of column or table changes will result in an ALTER statement to table in the target environment, whether these changes are made individually or all together:

* Changing table names
* Dropping existing columns
* Altering column data types
* Adding new columns

For column/table changes:

1. **Clone Table**: Creates internal table
2. **ALTER Operations**: Executes necessary ALTER statements
3. **Swap Cloned Table**: Replaces main table with clone
4. **Delete Table**: Drops internal table

##### Recreating Dimension Tables and Views

Tables and views are recreated when changes include:

* Join clause changes
* Adding transformations
* Business key changes
* Configuration changes

The following stages are executed:

1. Executes **CREATE** OR **REPLACE** statement.

#### Dimension Undeployment

If you delete a Dimension Node with type `table` or `view` from your Workspace, save those changes to Git, and then deploy them to another environment - the table will also be deleted in that environment. The following stages are executed.

For tables:

1. **Delete Internal Table**: Drops Coalesce internal table
2. **Delete Target Table**: Drops Snowflake target table

For views:

1. **Delete View**: Drops existing view from target environment.

## Fact

The Coalesce Fact UDN allows you to develop and deploy a Fact table in Snowflake.

A fact table stores measures that quantify business metrics, such as sales, cost of goods, or profit. Fact tables aggregate measures or numerical data of a business.

### Fact Node Configuration

The Fact node type has two configuration groups:

* [Node Properties](#fact-node-properties)
* [Options](#fact-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

### Fact Node Properties

| Property | Description |
|----------|-------------|
| **Storage Location** | Storage Location where the fact will be created |
| **Node Type** | Name of template used to create node objects |
| **Description** | A description of the node's purpose |
| **Deploy Enabled** | If **TRUE**: node will be deployed/redeployed when changes are detected<br/>If **FALSE**: node will not be deployed or will be dropped during redeployment |

### Fact Options

#### Fact Create as Table

![fact_options](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/fe15f4d1-fccc-4522-a75b-71682a8ef493)

| Setting | Description |
|---------|-------------|
| **Multi Source** | Toggle: True/False<br/>**True**: Multiple sources combined using UNION/UNION ALL<br/>- **UNION**: Combines with duplicate elimination. <br/>- **UNION ALL**:  Combines without duplicate elimination. <br/> **False**: Single source or joined sources |
| **Business key** | Required column for Fact table creation |
| **Truncate Before** | Toggle: True/False<br/>**True**: Uses INSERT OVERWRITE to overwrite existing data with new data loaded by task<br/>**False**: Uses INSERT to append new data into the target table |
| **Enable tests**| Option to specify data quality tests |
| **Distinct** | Toggle: True/False<br/>**True**: Group by All invisible<br/>**False**: Group by All visible |
| **Group by All** | Toggle: True/False<br/>**True**: DISTINCT invisible. Data is grouped by all columns for processing. <br/>**False**: DISTINCT visible |
| **Order By**| Toggle: True/False<br/>**True**: Sort options visible<br/>**False**: Sort options invisible |
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

#### Fact Create As View

![Work_options_view1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/7881c46e-0424-46ca-9a89-d111b5dbc379)

| Setting | Description |
|---------|-------------|
| **Override Create SQL** | Toggle: True/False<br/>**True**: Create custom SQL<br/>**False**: Create view SQL based on the options chosen are framed and executed. |
| **Multi Source** | Toggle: True/False<br/>**True**: Multiple sources combined using UNION/UNION ALL<br/>- **UNION**: Combines with duplicate elimination. <br/>- **UNION ALL**:  Combines without duplicate elimination. <br/> **False**: Single source or joined sources |
| **Distinct** | Toggle: True/False<br/>**True**: Group by All invisible<br/>**False**: Group by All visible |
| **Group by All** | Toggle: True/False<br/>**True**: DISTINCT invisible<br/>**False**: DISTINCT visible |

### Fact Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the UI.

![fact_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/e540d2d0-2623-4b99-a435-a26df5fe3306)

> 📘 Specify Group by and Order by Clauses
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Fact Deployment

#### Fact Initial Deployment

When deployed the firs time, the following stages are executed.

For tables:

1. **Create Fact Table**: Executes CREATE OR REPLACE statement and creates a table in the target environment.

For views:

1. **Create Fact View**: Executes CREATE OR REPLACE statement and creates a table in the target environment.

#### Fact Redeployment

Subsequent deployments may result in either altering the Fact Table or recreating the Fact table.

##### Altering Fact Tables

A few types of column or table changes will result in an ALTER statement to modify the Persistent Table in the target environment, whether these changes are made individually or all together:

1. Changing table names
2. Dropping existing columns
3. Altering column data types
4. Adding new columns

For column/table changes:

1. **Clone Table**: Creates internal table
2. **Alter Operations**: Executes necessary ALTER statements
3. **Swap Cloned Table**: Replaces main table with clone
4. **Delete Table**: Drops internal table

##### Recreating Fact Tables

Tables are recreated when:

* Join clause changes
* Adding transformations
* Business key changes
* Configuration changes

The following stages are executed:

1. Executes **CREATE** OR **REPLACE** statement.

##### Recreating Fact Views

Subsequent deployment of Fact node with changes:

* View definition
* Adding table descriptions
* Renaming views

The following stages are executed:

1. **Delete View**
2. **Create View**

#### Fact Undeployment

If you delete a Work Node with type `table` or `view` from your Workspace, save those changes to Git, and then deploy them to another environment - the table will also be deleted in that environment. The following stages are executed.

For tables:

1. **Delete Internal Table**: Drops Coalesce internal table
2. **Delete Target Table**: Drops Snowflake target table

For views:

1. **Delete View**: Drops existing view

## Factless Fact

The Coalesce Factless Fact UDN allows you to develop and deploy a Factless Fact table in Snowflake.

A factless fact table records events or situations that have no measures and has the same level of detail as the dimensions.

### Factless Fact Node Configuration

The Fact node type has two configuration groups:

* [Node Properties](#factless-fact-node-properties)
* [Options](#factless-fact-options)

### Factless Fact Node Properties

| Property | Description |
|----------|-------------|
| **Storage Location** | Storage Location where the fact will be created |
| **Node Type** | Name of template used to create node objects |
| **Description** | A description of the node's purpose |
| **Deploy Enabled** | If **TRUE**: node will be deployed/redeployed when changes are detected<br/>If **FALSE**: node will not be deployed or will be dropped during redeployment |

#### Factless Fact Options

![Factless_options](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/bf2430c4-2a62-4195-a817-e702461b2d14)

| Setting | Description |
|---------|-------------|
| **Create As** | Table is currently the only option |
| **Multi Source** | Toggle: True/False<br/>**True**: Multiple sources combined using UNION/UNION ALL<br/>- **UNION**: Combines with duplicate elimination. <br/>- **UNION ALL**:  Combines without duplicate elimination. <br/> **False**: Single source or joined sources |
| **Truncate Before** | Toggle: True/False<br/>**True**: Uses INSERT OVERWRITE<br/>**False**: Uses INSERT to append |
| **Enable tests** | Option to specify data quality tests |
| **Distinct** | Toggle: True/False<br/>**True**: Group by All invisible<br/>**False**: Group by All visible |
| **Group by All** | Toggle: True/False<br/>**True**: DISTINCT invisible<br/>**False**: DISTINCT visible |
| **Order By** | Toggle: True/False<br/>**True**: Sort options visible<br/>**False**: Sort options invisible |
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

### Factless Fact Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the UI.

![fact_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/fc432c42-0315-4fb5-8f93-7836190086ff)

> 📘 Specify Group by and Order by Clauses
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Factless Fact Deployment

#### Factless Fact Initial Deployment

1. **Create Fact Table**: Executes CREATE OR REPLACE statement

#### Factless Fact Redeployment

##### Altering Factless Fact Tables

A few types of column or table changes will result in an ALTER statement to modify the Persistent Table in the target environment, whether these changes are made individually or all together:

1. Changing table names
2. Dropping existing columns
3. Altering column data types
4. Adding new columns

For column/table changes:

1. **Clone Table**: Creates internal table
2. **ALTER Operations**: Executes necessary ALTER statements
3. **Swap Cloned Table**: Replaces main table with clone
4. **Delete Table**: Drops internal table

##### Recreating Factless Fact Tables

Tables are recreated when changes include:

* Join clause changes
* Adding transformations
* Business key changes
* Configuration changes

The following stages are executed:

1. Executes **CREATE** OR **REPLACE** statement

#### Factless Fact Undeployment

1. **Delete Internal Table**: Drops Coalesce internal table
2. **Delete Target Table**: Drops Snowflake target table

## View

The Coalesce View UDN allows you to develop and deploy a View in Snowflake.

A view allows the result of a query to be accessed as if it were a table. Views serve a variety of purposes, including combining, segregating, and protecting data.

### View Node Configuration

The View node type has two configuration groups:

* [Node Properties](#view-node-properties)
* [Options](#view-options)

![Fact_config](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

### View Node Properties

| Property | Description |
|----------|-------------|
| **Storage Location**| Storage Location where the view will be created |
| **Node Type** | Name of template used to create node objects |
| **Description** | A description of the node's purpose |
| **Deploy Enabled**| If **TRUE**: node will be deployed/redeployed when changes are detected<br/>If **FALSE**: node will not be deployed or will be dropped during redeployment |

### View Options

| Setting | Description |
|---------|-------------|
| **Override Create SQL** | Toggle: True/False<br/>**True**: Custom Create SQL<br/>**False**: Generated view SQL |
| **Multi Source** | Toggle: True/False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>- **INSERT**: Individual insert for each source<br/>**False**: Single source node or multiple sources combined using a join. |
| **Distinct** | Toggle: True/False<br/>**True**: Group by All invisible<br/>**False**: Group by All visible |
| **Group by All** | Toggle: True/False<br/>**True**: DISTINCT invisible<br/>**False**: DISTINCT visible |
| **Secure** | Toggle: True/False<br/>**True**: Creates a secured view<br/>**False**: Creates a normal view |

### View Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the Coalesce app.

> 📘 Specify Group by Clauses
>
> Best practice is to specify group by clauses in this space if you are not opting for the group by all provided in OPTIONS config.

### View Deployment

#### View Initial Deployment

The following stages are executed:

1. **Create View**: Executes CREATE OR REPLACE statement

#### View Redeployment

Views are recreated when changes include:

* View definition changes
* Description changes
* Adding secure option
* View renaming

The following stages are executed:

1. **Delete View**
2. **Create View**

#### View Undeployment

If a node is deleted from a Workspace, commited to Git and then that commit is deployed, then the Persistent Table in the target environment is dropped. The following stages are executed.

1. **Delete View**: Drops existing view

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

### Additional Resources

* [Macros](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/macros/macro-1.yml)
