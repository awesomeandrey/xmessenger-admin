@IsTest
private class GreetingServiceTest {
    @IsTest
    static void getGreetingPhrase(){
        GreetingService greetingService = new GreetingService();
        System.assert(String.isNotBlank(greetingService.getGreetingPhrase()));
    }
}