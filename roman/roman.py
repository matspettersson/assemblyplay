import sys

roman = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
arabic = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
arabicrest = 0
retstr = ""

if __name__ == "__main__":
    if(len(sys.argv) == 2):
#        print('Number of arguments:', len(sys.argv), 'arguments.')
#        print('Argument List:', str(sys.argv))
#        print('Argument:', str(sys.argv[1]))
        arabicrest = int(sys.argv[1])
    else:
        print("Specify argument.... I give you a 1")
        arabicrest = 1
    while arabicrest > 0:
        i = 0
        for x in arabic:
            if(arabicrest >= x):
                print("{:d} is greater or equal to {:d}   {:d}".format(arabicrest, x, i))
                arabicrest = arabicrest - x
                retstr = retstr + roman[i]
                break
#            else:
#                print("{:d} is smaller than {:d}".format(arabicrest, x))
            i = i + 1
    print("Roman: {}".format(retstr))