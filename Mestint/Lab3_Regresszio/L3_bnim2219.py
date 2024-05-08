import pandas as pd
import matplotlib.pyplot as plt
from sklearn import preprocessing
from sklearn.linear_model import LinearRegression

df = pd.read_csv("house_data.csv")
scaler = preprocessing.StandardScaler()
le = preprocessing.LabelEncoder()

# figure showing correlation between lat, long and price
fig = plt.figure()
ax = fig.add_subplot(projection="3d")
ax.plot(df["lat"], df["long"], df["price"], ".")
ax.set_xlabel("lat")
ax.set_ylabel("long")
ax.set_zlabel("price")

# transform and normalize all columns beside id and price

# cast int columns as float so we can normalize
cols = df.select_dtypes("int64").loc[:, df.select_dtypes("int64").columns != "id"].columns
df[cols] = df[cols].astype(float)

# label date and zipcode, then cast as float
le.fit(df['date'])
df['date'] = le.transform(df['date'])
le.fit(df['zipcode'])
df['zipcode'] = le.transform(df['zipcode'])
df[['date', 'zipcode']] = df[['date', 'zipcode']].astype(float)

# normalize columns
df.iloc[:, [1] + list(range(3, 21))] = (scaler.fit_transform(df.iloc[:, [1] + list(range(3, 21))].to_numpy()))

# training and test data samples
training_data = df.sample(frac=0.7)
test_data = df.drop(index=training_data.index)

# linear regression using the training data
X = training_data.iloc[:, 3:12]
y = training_data.iloc[:, 2]
reg = LinearRegression().fit(X, y)

# training and test errors
print("Columns 4-12")
print("Training error: " + str(1 - reg.score(X, y)))
X = test_data.iloc[:, 3:12]
y = test_data.iloc[:, 2]
print("Test error: " + str(1 - reg.score(X, y)))

# now using date and zipcode columns as well
X = training_data.iloc[:, [1] + list(range(3, 12)) + [16]]
y = training_data.iloc[:, 2]
reg = LinearRegression().fit(X, y)

# training and test errors
print("\nDate and zipcode included")
print("Training error: " + str(1 - reg.score(X, y)))
X = test_data.iloc[:, [1] + list(range(3, 12)) + [16]]
y = test_data.iloc[:, 2]
print("Test error: " + str(1 - reg.score(X, y)))

# now using lat and long columns as well
X = training_data.iloc[:, [1] + list(range(3, 12)) + [16, 17, 18]]
y = training_data.iloc[:, 2]
reg = LinearRegression().fit(X, y)

# training and test errors
print("\nLat and long included")
print("Training error: " + str(1 - reg.score(X, y)))
X = test_data.iloc[:, [1] + list(range(3, 12)) + [16, 17, 18]]
y = test_data.iloc[:, 2]
print("Test error: " + str(1 - reg.score(X, y)))

# now using all columns
X = training_data.iloc[:, [1] + list(range(3, 21))]
y = training_data.iloc[:, 2]
reg = LinearRegression().fit(X, y)

# training and test errors
print("\nAll columns")
print("Training error: " + str(1 - reg.score(X, y)))
X = test_data.iloc[:, [1] + list(range(3, 21))]
y = test_data.iloc[:, 2]
print("Test error: " + str(1 - reg.score(X, y)))

# lowest scoring 4 features
print("\nLowest scoring features:")
print(df.drop(columns=["id"]).corr()["price"].nsmallest(4).index.values)

X = test_data.iloc[:, list(range(3, 10)) + list(range(11, 16)) + [17, 19, 20]]
y = test_data.iloc[:, 2]
reg = LinearRegression().fit(X, y)
print("\nAll but the 4 lowest scoring features")
print("Training error: " + str(1 - reg.score(X, y)))
X = test_data.iloc[:, list(range(3, 10)) + list(range(11, 16)) + [17, 19, 20]]
y = test_data.iloc[:, 2]
print("Test error: " + str(1 - reg.score(X, y)))

plt.show()
