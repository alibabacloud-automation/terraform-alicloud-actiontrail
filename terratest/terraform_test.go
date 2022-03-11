package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/complete using Terratest.
func TestTerraformBasicExample(t *testing.T) {
	t.Parallel()
	uniqueId := random.UniqueId()
	uniqueNum := random.Random(100000, 999999)
	uniqueName := fmt.Sprintf("tf-testAcc%s", uniqueId)
	thisModuleName := uniqueName
	ossBucketName := fmt.Sprintf("tftestacc%d", uniqueNum)
	createOssBucket := "true"
	logProjectName := fmt.Sprintf("tftestacc%d", uniqueNum)
	eventRw := "All"
	ossKeyPrefix := fmt.Sprintf("tftestacc%d", uniqueNum)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/complete",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"this_module_name":  thisModuleName,
			"oss_bucket_name":   ossBucketName,
			"create_oss_bucket": createOssBucket,
			"log_project_name":  logProjectName,
			"event_rw":          eventRw,
			"oss_key_prefix":    ossKeyPrefix,
			// We also can see how lists and maps translate between terratest and terraform.
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualThisModuleName := terraform.Output(t, terraformOptions, "this_module_name")
	actualOssBucketName := terraform.Output(t, terraformOptions, "this_oss_bucket_name")
	actualLogProjectName := terraform.Output(t, terraformOptions, "this_log_project_name")
	actualEventRw := terraform.Output(t, terraformOptions, "this_event_rw")
	actualOssKeyPrefix := terraform.Output(t, terraformOptions, "this_oss_key_prefix")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, thisModuleName, actualThisModuleName)
	assert.Equal(t, ossBucketName, actualOssBucketName)
	assert.Equal(t, logProjectName, actualLogProjectName)
	assert.Equal(t, eventRw, actualEventRw)
	assert.Equal(t, ossKeyPrefix, actualOssKeyPrefix)

}
