---
layout: default
title: Embedded C#
parent: Getting Started
nav_order: 1
---



For more specific information on the nanoFramework hardware and software architecture, see [Understanding nanoFramework Architecture](https://docs.microsoft.com/en-us/previous-versions/windows/embedded/jj646623(v=vs.102)).

## **The CLR**

The CLR is an agent that manages code at execution time, providing core services such as memory management, thread management, and remoting, while also enforcing strict type safety and other forms of code accuracy that promote application security and robustness. In fact, the concept of code management is a fundamental principle of the CLR. Code that targets the CLR is referred to as managed code, whereas code that does not target the CLR is known as unmanaged code.

In addition, the managed environment of the runtime eliminates many common software issues. For example, the runtime automatically handles object layout and manages references to objects, releasing them when they are no longer being used. This automatic memory management resolves the two most common application errors — memory leaks and invalid memory references.

## **The Class Library**

The class library included with the nanoFramework is an object-oriented collection of reusable types you can use to develop embedded applications. Its classes are tightly integrated with the CLR and provide you with types you can employ to build functionality into your own managed code. For example, the nanoFramework collection classes implement a set of interfaces you can use to develop your own collection classes. Your collection classes will blend seamlessly with the classes in the .NET Framework.

Also, the class library contains specialized classes that are designed to give you access to the hardware features of your product's embedded system. For instance, your program can communicate across standard hardware interfaces, such as GPIO, I2C, and SPI. The powerful combination of standard .NET classes and hardware-specific objects can greatly reduce the amount of time required to develop your embedded system.

The nanoFramework class library includes classes, interfaces, and value types that expedite and optimize the development process and provide access to system functionality. These types are the foundation on which you build your embedded applications and components. They provide a rich set of interfaces, as well as abstract and concrete (nonabstract) classes. You can either use the concrete classes as they are or, in many cases, derive your own classes from them. To use an interface's functionality, you can either create a class that implements the interface or derive a class from one of the nanoFramework classes that implements the interface.

## **Naming Conventions**

The nanoFramework types use a dot syntax naming scheme that connotes a hierarchy. This technique groups related types into namespaces, making them easy to search and reference. The first part of the full name — up to the rightmost dot — is the namespace name. The last part of the name is the type name. For example, System.Collections.ArrayList represents the ArrayList type, which belongs to the System.Collections namespace. The types in System.Collections can be used to manipulate collections of objects.

This naming scheme makes it easy for library developers extending the nanoFramework to create hierarchical groups of types and name them in a consistent, informative manner. It is expected that library developers will use the following syntax when creating names for their namespaces:

CompanyName.TechnologyName

Microsoft.Word is an example of a namespace that conforms to this naming convention.

The use of naming patterns to group related types into namespaces is a very handy way to build and document class libraries. However, this naming scheme has no effect on visibility, member access, inheritance, security, or binding. A namespace can be partitioned across multiple assemblies; and conversely, a single assembly can contain types from multiple namespaces. The assembly provides the formal structure for versioning, deployment, security, loading, and visibility in the CLR.

## **Essential Namespaces**

The System namespace is the root namespace for many of the fundamental types in the nanoFramework. This namespace includes classes that represent the base data types used by all applications: Object (the root of the inheritance hierarchy), Byte, Char, Array, Int32, and String, among others. Many of these types correspond to the primitive data types provided by C#, which is currently the only programming language supported by the nanoFramework CLR.

Other important namespaces in nanoFramework programming are Microsoft.SPOT and Microsoft.SPOT.Hardware. These namespaces provide access to much of the hardware-level functionality that the nanoFramework supports.

## Compiling for the nanoFramework



In .NET, compilers, such as the C# compiler, transform the source code to DLL's or executables containing the common intermediate language and metadata for a self-describing code. The CLR then executes the managed code. 

The .NET Micro Framework uses a special intermediate language representation optimized for size. A global, shared string table for text and metadata such as type, method, and field names is used to reduce ROM and RAM usage on the devices. 

Therefore, the .NET Micro Framework metadata processor tool generates the optimized pe-files to be deployed out of the managed .NET assemblies. Visual Studio and the .NET Micro Framework plug-in hide all these steps from you (see Figure 1-12). You will not see that the metadata processor is used, but you should know that Visual Studio actually deploys special optimized assemblies that the .NET Micro Framework CLR will interpret. 

Currently, the .NET Micro Framework supports only Visual C#. Theoretically, every .NET 

language compiler could be supported, since the metadata processor parses common .NET 

assemblies that each .NET compiler should be able to generate. In practice, Visual Basic uses a special Visual Basic runtime library that has not yet been ported to the .NET Micro Framework. 