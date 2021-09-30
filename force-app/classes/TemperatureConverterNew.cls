public class TemperatureConverterNew {
    //SAMPLE Takes a Fahrenheit temperature and returns the Celsius equivalent. Sample 123456 Test1234566
	
    public static Decimal FahrenheitToCelsius(Decimal fh) {
        Decimal cs = (fh - 32) * 5/9;
        return cs.setScale(2);
    }
}