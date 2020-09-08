function usage {
    echo "You much supply the input file, number to change and the number to change to. Like so:"
    echo "swap.sh Bill.pdf 07987654321 07123456789"
}

if [ -z "$1"  ] || [ -z "$2"  ] || [ -z "$3"  ]; then
    usage
    exit 1
fi

docker build -t dog_pdf_edit . ; docker run -v $(pwd):/app dog_pdf_edit app/$1 $2 $3
