:::mermaid
  graph TD
    t1(class circuit)
    t1.1(circuit graph)
    t1.1.1(class solid)
    t1.1.2(class sprite)
    t1.1.1.1(class wire)
    t1.1.2.1(class switch)
    t1.1.2.2(class bulb)
    t1.1.2.3(class battery)
    t1.1.2.4(class connector)

    t1 --> t1.1
    t1.1 --> t1.1.1 & t1.1.2
    t1.1.1 --> t1.1.1.1
    t1.1.2 --> t1.1.2.1 & t1.1.2.2 & t1.1.2.3 & t1.1.2.4   
:::