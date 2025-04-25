// C++ program to find minimum number
// of operations to convert s1 to s2
#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

// Recursive function to find number of operations 
// needed to convert s1 into s2.
int editDistRec(string& s1, string& s2, int m, int n, vector<vector<int>> &memo) {
  
    // If first string is empty, the only option is to
    // insert all characters of second string into first
    if (m == 0) return n;

    // If second string is empty, the only option is to
    // remove all characters of first string
    if (n == 0) return m;
    
    // If value is memoized
    if (memo[m][n]!=-1) return memo[m][n];

    // If last characters of two strings are same, nothing
    // much to do. Get the count for
    // remaining strings.
    if (s1[m - 1] == s2[n - 1]) 
      return memo[m][n] = editDistRec(s1, s2, m - 1, n - 1, memo);

    // If last characters are not same, consider all three
    // operations on last character of first string,
    // recursively compute minimum cost for all three
    // operations and take minimum of three values.
    return memo[m][n] = 
            1 + min({editDistRec(s1, s2, m, n - 1, memo),  
                    editDistRec(s1, s2, m - 1, n, memo),   
                    editDistRec(s1, s2, m - 1, n - 1, memo)}); 
}

// Wrapper function to initiate the recursive calculation
int editDistance(string& s1, string& s2) {
    int m = s1.length(), n = s2.length();
    vector<vector<int>> memo(m+1, vector<int>(n+1, -1));
    return editDistRec(s1, s2, m, n, memo);
}

int main() {
    
    string s1 = "abcd";
    string s2 = "bcfe";

    cout << editDistance(s1, s2);

    return 0;
}