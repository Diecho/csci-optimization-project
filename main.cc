#include <iostream>
#include "cvs_reader.h"
using namespace std;

int main() {
    string filename = "student_dropout_dataset_v3_2500.csv";
    
    cout << "Loading data from: " << filename << "...\n";
    
    vector<Student> students = read_cvs(filename);
    
    if (students.empty()) {
        cout << "Failed.\n";
        return 1;
    }

    cout << "Successfully loaded " << students.size() << " valid students!\n\n";



    std::cout << "--- First Student Details ---\n";
    std::cout << "Gender: " << students[0].gender << "\n";
    std::cout << "GPA: " << students[0].gpa << "\n";
    std::cout << "Stress Index: " << students[0].stress_index << "\n";
    std::cout << "Dropout: " << students[0].dropout << "\n";
    
    return 0;
}
