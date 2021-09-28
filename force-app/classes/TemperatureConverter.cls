public class TemperatureConverter {
    // Sample Takes a Fahrenheit temperature and returns the Celsius equivalent. Sample Test Test Sample
    public static Decimal FahrenheitToCelsius(Decimal fh) {
        Decimal cs = (fh - 32) * 5/9;
        return cs.setScale(2);
    }
}
