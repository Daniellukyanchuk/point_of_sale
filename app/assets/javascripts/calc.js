// Calculation for subtotal

function multiply()
{
    // Get the input values
    a = Number(document.getElementById('quantity').value);
    b = Number(document.getElementById('sale_price').value);

    // Do the multiplication
    c = a*b;

    // Set the value of the subtotal
    document.getElementById('subtotal').value=c;
}