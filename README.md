# Daily

Daily is a Swift app to help you track daily goals. The app will remind you to set a goal every day at 9:00am (if you haven't already), and will "celebrate" when you complete a goal.

## Time Summary

The entire project took me around 7 hours to complete. I wanted to highlight the architecture I like using for MVPs, and it can take a bit of time to set up. Once it's set up though, I'm able to build things fast and flexibly.

## Libraries

I only used Swinject and SwinjectAutoregistration as dependencies, which are libraries that facilitate dependency injection (see more below). The default iOS SDK is more than enough to build MVPs quickly.

## Architecture

Daily is using an architecture similar to MVVM, and leverages Combine for data flow. UI is built in SwiftUI.

## SwiftUI Previews

The app UI layer is set up to include a SwiftUI Preview for any file. To view them, simply open the project with Xcode, and select a file with the pattern `*View.swift`. To show the preview panel, press `CMD + OPT + Enter`. You may need to refresh it to get a live interactive view. This is extremely useful for fast iteration and small tweaks, since the preview updates in real time.

## Dependency Injection

Daily uses dependency injection to link code. This is implemented with the 3rd part library Swinject (I'm a maintainer of this library). Each class is wrapped in a protocol, and registered to a central Container using an Assembly (usually found at the bottom of each file). The assemblies are aggregated and applied to the MainAssembler, which can then build the object graph.

This setup allows for flexibility in dependencies, as well as facilitation of testing.

I attempted to leverage SwiftUI environment to pass the Resolver around, but there were issues with initialization. Instead, I opted to pass the Resolver directly in each init.

## Tests

No tests were written for Daily, but they could be easily added. The app was simple enough that I could test it manually to ensure functionality. I personally find tests slow down development in the very early stages, and typically leave them out of MVPs. Once we know we want to keep a feature, or the feature is known to be long term, I'll make sure to add tests.

## Mock Backend

The backend is completely mocked. Implementation details for this can be found in `Network/URLSession/CNURLSessionMock.swift`. The backend caches the goals list between app launches.

The email and password to use for sign in is:

```
Email: mark@creatornow.com
Password: password
```
## Trade-Offs

I opted to leave out the sign up flow, since it's not super interesting, and I wanted to focus more on the architecture / main features. I also made the "Create Goal" screen a bit more simple for similar reasons.

## Enjoyment

I really loved designing the UI for this app. Designing the app icon, color scheme, and UI was a blast! I really like how playful the color scheme makes the app.
