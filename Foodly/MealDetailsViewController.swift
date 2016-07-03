//
//  MealsDetailsController.swift
//
//  Created by Marcel Felder on 24.06.16.
//  Copyright © 2016 XeriSoft. All rights reserved.
//

import UIKit

class MealDetailsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    
    @IBOutlet weak var mealNameTextField: UITextField!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var meal: Meal?
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = self.mealNameTextField.text ?? ""
            let photo = self.mealImageView.image
            let rating = self.ratingControl.rating
            
            self.meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
    // MARK: Actions
    
    @IBAction func selectPhoto(sender: UITapGestureRecognizer) {
        // Hide the keyboard
        mealNameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        mealNameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    func checkValidMealName() {
        // Disable the Save button if the text field is empty.
        let text = mealNameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        mealImageView.image = selectedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        mealNameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            mealNameTextField.text   = meal.name
            mealImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidMealName()
    }
    
}