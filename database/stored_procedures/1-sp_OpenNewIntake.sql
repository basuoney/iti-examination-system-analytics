/*
Stored Procedure: sp_OpenNewIntake
Purpose: Opens a new intake in the system by adding a record to the Intake table.

Parameters:
    @Intake_Year INT
        - The academic year of the new intake to be created.

Logic & Rules:
✅ Only targets the Intake table.
✅ Accepts only the intake year as input; Intake_ID is auto-generated.
✅ Rejects duplicate entries if the Intake_Year already exists.
✅ Prevents opening an intake for a past year (year < current max Intake_Year).
✅ Inserts the new intake if all checks pass and returns the new Intake_ID.

Output:
- Prints a success message with the newly created Intake_ID and Year.
- Prints an error message and aborts if any validation fails.
*/


CREATE OR ALTER PROCEDURE SP_OpenNewIntake
    @Intake_Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaxYear INT, @NewIntakeID INT;

    -- 1. Get current max intake year
    SELECT @MaxYear = MAX(Intake_Year) FROM Intake;

    -- 2. Reject if trying to open a past year
    IF @MaxYear IS NOT NULL AND @Intake_Year < @MaxYear
    BEGIN
        PRINT '❌ Cannot open an intake for a previous year.';
        RETURN;
    END;

    -- 3. Reject if year already exists
    IF EXISTS (SELECT 1 FROM Intake WHERE Intake_Year = @Intake_Year)
    BEGIN
        PRINT '❌ Intake year already exists.';
        RETURN;
    END;

    -- 4. Insert new intake
    INSERT INTO Intake (Intake_Year)
    VALUES (@Intake_Year);

    -- 5. Get the newly generated ID
    SELECT @NewIntakeID = SCOPE_IDENTITY();

    PRINT CONCAT('✅ New intake opened successfully: Intake_ID = ', @NewIntakeID, ', Year = ', @Intake_Year);
END;
GO

