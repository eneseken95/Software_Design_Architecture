import Foundation

let student1 = Student(firstName: "John", lastName: "Mark", studentID: 1)

let grade = ExamGrade(midterm: 80, final: 90)

let strategy = StandardGradeCalculation()
let converter = FourScaleGradeConverter()

let studentModule = StudentModule(calculationStrategy: strategy, converter: converter)

let result = studentModule.calculateAndConvert(grade: grade)
print(result)

let notification = EmailNotificationService()
notification.sendNotification(subject: "Grade Result", message: result)
