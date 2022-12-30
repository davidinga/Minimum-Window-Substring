/*
    Given two strings s and t of lengths m and n respectively, return the minimum window 
    substring
     of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".
    
    The testcases will be generated such that the answer is unique.
    
    Example 1:
    
    Input: s = "ADOBECODEBANC", t = "ABC"
    Output: "BANC"
    Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
    Example 2:
    
    Input: s = "a", t = "a"
    Output: "a"
    Explanation: The entire string s is the minimum window.
    Example 3:
    
    Input: s = "a", t = "aa"
    Output: ""
    Explanation: Both 'a's from t must be included in the window.
    Since the largest window of s only has one 'a', return empty string.
    
    Constraints:
    
    m == s.length
    n == t.length
    1 <= m, n <= 105
    s and t consist of uppercase and lowercase English letters.

    Problem:
    - Given strings s and t, find minimum substring in s where all
      characters in t are included.

    Questions:
    - Assume s.count >= t.count?
    - If no substring exists, return empty string?
    - Can we discard repeating characters?
    - Assume case matters?

    Input: s: String, t: String
    Output: substring: String

    Example:
    - Input: s: "ccat" t: "cat"
    - Output: "cat"

    - Input: s: "cc" t: "t"
    - Output: ""

    - Input: s: "toys" t: "tyo"
    - Output: "toy"

    Thoughts:
    - store min substring in [Character] for quick count access
    - Store t in Dictionary with [Character: Int] => (character, freq)
    - Sliding window
    - When all characters included in substring, decrement leftIdx
    - Everytime character in dictionary is in substring, decrement freq
    - When all freq are zero, everything is included in substring
    - If rightIdx - leftIdx + 1 < minsubstring.count, set new min

    Algorithm:
    - s => [Character] for convenient traversal
    - Dictionary: [Character: Int] => (character, freq)
    - minSubstr: [Character]
    - Build dictionary from t
    - Pointer leftIdx
    - For loop to go through s with pointer to rightIdx
        - If character in dictionary and freq > 0
            - Decrement freq
        - Loop through dictionary - allSatisfy
            - If all zero, min(currSubstring, minSubstr)
            - If character at leftIdx in Dictionary
                - Increment freq
            - Move pointer leftIdx to right
*/
func minWindow(_ s: String, _ t: String) -> String {
    let s = s.map(Character.init)
    var freqs: [Character: Int] = [:]
    var minSubstr: ArraySlice<Character> = []

    for char in t {
        freqs[char, default: 0] += 1
    }

    var leftIdx = 0
    for rightIdx in s.indices {
        if let count = freqs[s[rightIdx]] {
            freqs[s[rightIdx]]! -= 1
        }

        while freqs.values.allSatisfy { $0 <= 0 } {
            if minSubstr.isEmpty {
                let currSubstr = s[leftIdx...rightIdx]
                minSubstr = currSubstr
            } else {
                if rightIdx - leftIdx + 1 < minSubstr.count {
                    let currSubstr = s[leftIdx...rightIdx]
                    minSubstr = currSubstr
                }
            }
            if freqs[s[leftIdx]] != nil {
                freqs[s[leftIdx]]! += 1
            }
            leftIdx += 1
        }
    }

    return String(minSubstr)
}