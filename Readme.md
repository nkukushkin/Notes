# Notes

This is an exploration of the [Coordinator](http://khanlou.com/2015/10/coordinators-redux) pattern, implemented using view controller containment.

### Demo

![](.github/Media/Demo.gif?raw=true)

### Ideas

Coordinator is a `UIViewController` that takes care of the navigation. It can either directly embed child view controllers, or embed another container view controller (`UINavigationController`, `UITabBarController`…) and use its functionality. 

Coordinators can also inherit container view controllers, for example, by calling a `UIViewController` property `navigationController: NavigationController?`, that will traverse the hierarchy and return the first navigation controller that can be used.  

You can present coordinators the same way you would present any other view controller, for example, you can have a coordinator be pushed onto navigation controller’s stack, or presented modally; and then it automatically manages its flow from there.

Memory management with this approach is trivial, coordinators are strongly held by the view controller hierarchy, once they leave it, they get deallocated.

### Diagram

![](.github/Media/Diagram.png?raw=true)

### Reading

- Soroush Khanlou’s [Coordinators Redux](http://khanlou.com/2015/10/coordinators-redux).  
- Dave Delong’s [A Better MVC](https://davedelong.com/blog/2017/11/06/a-better-mvc-part-1-the-problems/).
