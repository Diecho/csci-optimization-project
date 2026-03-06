#include <iostream>
#include "cvs_reader.h"
using namespace std;

int main() {
    string filename = "student_dropout_dataset_v3_10m.csv";
    
    cout << "Loading data from: " << filename << "...\n";
    
    vector<Student> students = read_cvs(filename);
    
    if (students.empty()) {
        cout << "Failed.\n";
        return 1;
    }

    cout << "Successfully loaded " << students.size() << " valid students!\n\n";
	

	int n_of_drop = 0;
	int total_students = 0;
	int non_drop_students = 0;	

	int count_f = 0;
	int count_m = 0;

	double total_stress_drop = 0;
	double total_stress_all = 0;
	double total_stress_non = 0;

	double total_gpa_drop = 0;
	double total_gpa_all = 0;
	double total_gpa_non = 0;


	for(Student& st: students){
		total_students++;	
		total_stress_all+=st.stress_index;
		total_gpa_all+=st.gpa;
		if(st.dropout == 1){
			++n_of_drop;
			total_stress_drop+=st.stress_index;
			total_gpa_drop+=st.gpa;

			if(st.gender == "Male"){
				++count_m;
			}else {
				++count_f;
			}
					
		}	
		else {
			total_stress_non+=st.stress_index;
			total_gpa_non+=st.gpa;
			non_drop_students++;
		}
	}	
	
    cout << "--- Data ---\n";
	
    cout << "Total Number of student: " << total_students << "\n";
    cout << "Total Number of student dropouts: " << n_of_drop << "\n";

    cout << "Dropouts %: " << (static_cast<float>(n_of_drop) / total_students) * 100 << "\n";

    cout << "------------------------------------------\n";

    cout << "Male dropout n: " << count_m << "\n";
    cout << "Female dropout n: " << count_f << "\n";

    cout << "Male dropout %: " << (static_cast<float>(count_m) / n_of_drop) * 100 << "\n";
    cout << "Female dropout %: " << (static_cast<float>(count_f) / n_of_drop) * 100 << "\n";
    
    cout << "------------------------------------------\n";

    cout << "Avg stress_index for a all student: " << total_stress_all / total_students << "\n";
    cout << "Avg stress_index for a non-dropout student: " << total_stress_non / non_drop_students<< "\n";
    cout << "Avg stress_index for a dropout student: " << total_stress_drop / n_of_drop << "\n";


    cout << "------------------------------------------\n";

    cout << "Avg GPA for a all student: " << total_gpa_all / total_students << "\n";
    cout << "Avg GPA for a non-dropout student: " << total_gpa_non / non_drop_students<< "\n";
    cout << "Avg GPA for a dropout student: " << total_gpa_drop / n_of_drop << "\n";

    cout << "------------------------------------------\n";
    return 0;
}

