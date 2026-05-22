import pandas as pd
import glob
import os

# Get the current working directory
current_directory = os.getcwd()

# Retrieve the list of TXT files in the current working directory
txt_files = glob.glob(os.path.join(current_directory, "*.txt"))

# Iterate over the TXT files
for txt_file in txt_files:
    try:
        # Read each classification report into a DataFrame
        report_data = pd.read_csv(txt_file, delimiter="\t", skiprows=2)

        # Check for required columns
        required_columns = {"kmers", "reads", "cov", "rank"}
        if not required_columns.issubset(report_data.columns):
            print(f"Error: Missing required columns in {txt_file}. Found columns: {report_data.columns}")
            continue

        # Filter the DataFrame based on the "kmers" column
        filtered_data = report_data[report_data["kmers"] >= 500]

        # Avoid division by zero
        filtered_data = filtered_data[filtered_data["reads"] != 0]

        # Perform the calculation and store the result in the "Values" column
        filtered_data.loc[:, "Values"] = filtered_data["kmers"] / filtered_data["reads"] * filtered_data["cov"]

        # Filter the DataFrame based on the "Values" column
        filtered_data = filtered_data[filtered_data["Values"] < 1]

        # Filter the DataFrame based on the "rank" column
        filtered_data = filtered_data[filtered_data["rank"] == "species"]

        # Create a copy of the filtered DataFrame
        filtered_data_copy = filtered_data.copy()

        # Construct the Excel file name by replacing the file extension and maintaining the same directory
        excel_file = txt_file.replace(".txt", ".xlsx")

        # Convert the copy to an Excel file
        filtered_data_copy.to_excel(excel_file, index=False, engine="openpyxl")

        print(f"{txt_file} converted to {excel_file} successfully.")
    except Exception as e:
        print(f"Error processing {txt_file}: {e}")